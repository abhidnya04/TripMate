import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetManagerPage extends StatefulWidget {
  final String itineraryId;

  const BudgetManagerPage({super.key, required this.itineraryId});

  @override
  State<BudgetManagerPage> createState() => _BudgetManagerPageState();
}

class _BudgetManagerPageState extends State<BudgetManagerPage> {
  double? totalBudget;
  double totalSpent = 0;
  List<Map<String, dynamic>> expenses = [];

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    fetchBudgetAndExpenses();
  }

// Future<void> fetchBudgetAndExpenses() async {
//   final userId = supabase.auth.currentUser?.id;
//   if (userId == null) {
//     debugPrint('User not logged in');
//     return;
//   }

//   try {
//     debugPrint('Fetching total_budget for itineraryId: ${widget.itineraryId}');

//     final itineraryResponse = await supabase
//         .from('itineraries')
//         .select('total_budget')
//         .eq('id', widget.itineraryId)
//         .single();

//     debugPrint('Itinerary response: $itineraryResponse');

//     final budget = itineraryResponse['total_budget'];
//     totalBudget = (budget != null) ? budget.toDouble() : 0.0;

//     debugPrint('Total budget fetched: $totalBudget');

//     final expenseResponse = await supabase
//         .from('expenses')
//         .select()
//         .eq('itinerary_id', widget.itineraryId);

//     debugPrint('Expenses fetched: $expenseResponse');

//     expenses = List<Map<String, dynamic>>.from(expenseResponse);
//     totalSpent = expenses.fold(
//       0,
//       (sum, item) => sum + (item['amount'] as num).toDouble(),
//     );

//     setState(() {});
//   } catch (e) {
//     debugPrint('Error loading budget/expenses: $e');
//   }
// }
Future<void> fetchBudgetAndExpenses() async {
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return;

  try {
    final itineraryResponse = await supabase
        .from('itineraries')
        .select('total_budget')
        .eq('id', widget.itineraryId)
        .single();

    double? budget = (itineraryResponse['total_budget'] as num?)?.toDouble();

    // If total_budget is -1 (unset), prompt user to enter it
    if (budget == null || budget == -1) {
      final enteredBudget = await showDialog<double>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: const Text('Enter Total Budget'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Budget (₹)',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final value = double.tryParse(controller.text);
                  if (value != null && value > 0) {
                    Navigator.of(context).pop(value);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );

      // If user entered a valid budget, update in Supabase
      if (enteredBudget != null) {
        await supabase
            .from('itineraries')
            .update({'total_budget': enteredBudget})
            .eq('id', widget.itineraryId);

        budget = enteredBudget;
      } else {
        // If user canceled or entered invalid, don't proceed
        return;
      }
    }

    totalBudget = budget;

    final expenseResponse = await supabase
        .from('expenses')
        .select()
        .eq('itinerary_id', widget.itineraryId);

    expenses = List<Map<String, dynamic>>.from(expenseResponse);
    totalSpent = expenses.fold(
      0,
      (sum, item) => sum + (item['amount'] as num).toDouble(),
    );

    setState(() {});
  } catch (e) {
    debugPrint('Error loading budget/expenses: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    final remaining = (totalBudget ?? 0) - totalSpent;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (_) => AddExpenseDialog(
        itineraryId: widget.itineraryId,
        onExpenseAdded: fetchBudgetAndExpenses,
      ),
    );
  },
  child: const Icon(Icons.add),
  backgroundColor: Colors.blue,
),

      appBar: AppBar(
        title: const Text('Manage Budget'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: totalBudget == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.blue.shade50,
                    elevation: 4,
                    child: ListTile(
                      title: const Text('Total Budget', style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text('₹${totalBudget!.toStringAsFixed(2)}'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.green.shade50,
                    elevation: 4,
                    child: ListTile(
                      title: const Text('Remaining Budget', style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text('₹${remaining.toStringAsFixed(2)}'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Expenses:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: expenses.isEmpty
                        ? const Center(child: Text('No expenses added yet.'))
                        : ListView.builder(
                            itemCount: expenses.length,
                            itemBuilder: (context, index) {
                              final exp = expenses[index];
                              return Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(exp['type']),
                                  subtitle: Text(exp['note'] ?? ''),
                                  trailing: Text('₹${(exp['amount'] as num).toStringAsFixed(2)}'),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  
}


class AddExpenseDialog extends StatefulWidget {
  final String itineraryId;
  final VoidCallback onExpenseAdded;

  const AddExpenseDialog({
    super.key,
    required this.itineraryId,
    required this.onExpenseAdded,
  });

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  String type = 'Food';
  double amount = 0;
  String? note;

  final supabase = Supabase.instance.client;

  final List<String> expenseTypes = ['Food', 'Travel', 'Stay', 'Shopping', 'Other'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: type,
              items: expenseTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (value) => setState(() => type = value!),
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              validator: (val) => val == null || val.isEmpty ? 'Enter amount' : null,
              onSaved: (val) => amount = double.tryParse(val ?? '0') ?? 0,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Note (optional)'),
              onSaved: (val) => note = val,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final userId = supabase.auth.currentUser?.id;

              if (userId == null) return;

              await supabase.from('expenses').insert({
                'user_id': userId,
                'itinerary_id': widget.itineraryId,
                'type': type,
                'amount': amount,
                'note': note,
              });

              widget.onExpenseAdded(); // Refresh list
              Navigator.pop(context); // Close dialog
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
