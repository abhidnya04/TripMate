import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  
  bool isLoading = false; // For showing a loading indicator

  Future<void> updatePassword() async {
  final newPassword = _passwordController.text.trim();

  if (newPassword.isEmpty || newPassword.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password must be at least 6 characters')),
    );
    return;
  }

  setState(() => isLoading = true);

  try {
    final session = supabase.auth.currentSession;
    
    if (session == null) {
      throw 'Session expired or invalid reset link. Please request a new password reset.';
    }

    await supabase.auth.updateUser(UserAttributes(password: newPassword));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully! Please log in.')),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  } catch (error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  } finally {
    if (mounted) setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set New Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter new password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: updatePassword,
                    child: const Text('Update Password'),
                  ),
          ],
        ),
      ),
    );
  }
}
