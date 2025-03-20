import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class logotalert extends StatefulWidget {
  const logotalert({super.key});

  @override
  State<logotalert> createState() => _logotalertState();
}

class _logotalertState extends State<logotalert> {

   final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to log out ?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await supabase.auth.signOut();  // Sign out user
                if (mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false); // Redirect to Login Page
                }
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: $error')),
                );
              }

            },
            child: const Text("Yes"),
          ),
      ],

    );
  }
}