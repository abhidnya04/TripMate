import 'package:appdev/gemini_service.dart';
import 'package:appdev/pages/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'budget_selection.dart';
import 'itinerary_page.dart';
import 'people_selection.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  final TextEditingController tripNameController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  String selectedBudget = ""; // Track the selected budget
  String selectedPeople = "";

  @override
  void dispose() {
    tripNameController.dispose();
    destinationController.dispose();
    durationController.dispose();
    super.dispose();
  }

  Future<void> _createTrip() async {
    if (tripNameController.text.isEmpty ||
        destinationController.text.isEmpty ||
        durationController.text.isEmpty ||
        selectedBudget.isEmpty ||
        selectedPeople.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Show loading dialog
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );

    showDialog(
      
  context: context,
  barrierDismissible: false,
  builder: (context) => Dialog(
    backgroundColor: Colors.transparent,

    child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.blue
            ),
            child: Image.asset(
              'assets/bus_loading.gif',
              height: 120,
              width: 120,
            ),
          ),

        ],
      ),
    ),
);


    try {
      GeminiService geminiService = GeminiService();
      String itinerary = await geminiService.generateItinerary(
        tripNameController.text,
        destinationController.text,
        durationController.text,
        selectedBudget,
        selectedPeople,
      );

      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
      }
      // yaha ----
      

      // Navigate to Itinerary Page
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItineraryPage(
              itinerary: itinerary,
              userTitle: tripNameController.text,
              ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog if there's an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to generate itinerary: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        toolbarHeight: 50,

        centerTitle: true,
        title: const Text(
          'Lets Create your Trip',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/create2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Text('Lets create your trip with AI', style: GoogleFonts.pattaya(),),
                    const SizedBox(height: 20),

                    // Custom Text Fields
                    CustomTextField(
                      label: "Trip Name",
                      hintText: "Enter Trip Name",
                      controller: tripNameController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "Destination",
                      hintText: "Enter Destination",
                      controller: destinationController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "Duration (days)",
                      hintText: "Enter No. Of Days",
                      controller: durationController,
                      
                    ),

                    const SizedBox(height: 20),

                    // Budget Selection
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Select Budget",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BudgetSelection(
                      selectedBudget: selectedBudget,
                      onBudgetSelected: (budget) {
                        setState(() {
                          selectedBudget = budget;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // People Selection
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Who Are You Traveling With?",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: PeopleSelection(
                        selectedPeople: selectedPeople,
                        onPeopleSelected: (people) {
                          setState(() {
                            selectedPeople = people;
                          });
                        },
                      ),
                    ),

                    // const SizedBox(height: 10),

                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createTrip,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text("Create Trip"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}





// import 'package:appdev/gemini_service.dart';
// import 'package:appdev/pages/custom_text_field.dart';
// import 'package:flutter/material.dart';

// import 'budget_selection.dart';
// import 'itinerary_page.dart';
// import 'people_selection.dart';

// class CreateTrip extends StatefulWidget {
//   const CreateTrip({super.key});

//   @override
//   State<CreateTrip> createState() => _CreateTripState();
// }

// class _CreateTripState extends State<CreateTrip> {
//   final TextEditingController tripNameController = TextEditingController();
//   final TextEditingController destinationController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();

//   String selectedBudget = ""; // To track the selected budget
//   String selectedPeople = "";

//   @override
//   void dispose() {
//     tripNameController.dispose();
//     destinationController.dispose();
//     durationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70,
//         centerTitle: true,
//         title: const Text(
//           'Create Trip',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: constraints.maxHeight,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom + 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Image Section
//                     SizedBox(
//                       height: 160,
//                       width: double.infinity,
//                       child: Image.asset(
//                         'lib/images/travel.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Using CustomTextField component
//                     //Trip name
//                     CustomTextField(
//                         label: "Name Trip",
//                         hintText: "Enter Trip Name",
//                         controller: tripNameController),
//                     const SizedBox(height: 15),
//                     CustomTextField(
//                       label: "Travel Destination",
//                       hintText: "Enter Destination",
//                       controller: destinationController,
//                     ),
//                     const SizedBox(height: 15),
//                     CustomTextField(
//                       label: "Duration",
//                       hintText: "Enter No. Of Days",
//                       controller: durationController,
//                     ),

//                     const SizedBox(height: 20),

//                     // Budget Selection
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "Select Budget",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     BudgetSelection(
//                       selectedBudget: selectedBudget,
//                       onBudgetSelected: (budget) {
//                         setState(() {
//                           selectedBudget = budget;
//                         });
//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     // no of peopl
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "Who Are You Traveling With?",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     SizedBox(
//                       height: 150,
//                       child: PeopleSelection(
//                         selectedPeople: selectedPeople,
//                         onPeopleSelected: (people) {
//                           setState(() {
//                             selectedPeople = people;
//                           });
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             if (tripNameController.text.isEmpty ||
//                                 destinationController.text.isEmpty ||
//                                 durationController.text.isEmpty ||
//                                 selectedBudget.isEmpty ||
//                                 selectedPeople.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text("Please fill in all fields")),
//                               );
//                               return;
//                             }

//                             GeminiService geminiService = GeminiService();
//                             String itinerary =
//                                 await geminiService.generateItinerary(
//                               tripNameController.text,
//                               destinationController.text,
//                               durationController.text,
//                               selectedBudget,
//                               selectedPeople,
//                             );

//                             // Navigate to new page to display itinerary
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     ItineraryPage(itinerary: itinerary),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             textStyle: const TextStyle(fontSize: 18),
//                           ),
//                           child: const Text("Create Trip"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
