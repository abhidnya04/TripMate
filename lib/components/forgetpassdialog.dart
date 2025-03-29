import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController emailController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await supabase.auth.resetPasswordForEmail(email,
      redirectTo: 'your-app://reset-password'
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );
// Close the dialog
    } catch (error) {
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffedf2fb),
      title: const Text("Reset Password"),
      content: TextField(

        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          focusColor: Color(0xff03045e),
          // enabledBorder: OutlineInputBorder(),
          floatingLabelStyle: TextStyle(color: Color(0xff03045e)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff03045e))

          ),
          labelText: "Enter your email"), style: TextStyle(color: Color(0xff03045e)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel" , style: TextStyle(color: Color(0xff03045e)),),
        ),
        ElevatedButton(
          onPressed: resetPassword,
          child: const Text("Send Reset Link"),
          // style: ,
        ),
      ],
    );
  }
}

void configureDeepLink(BuildContext context) {
  final appLinks = AppLinks();

  appLinks.uriLinkStream.listen((uri) {
    if (uri != null && uri.host == 'reset-password') {
        Navigator.of(context).pushNamedAndRemoveUntil('/updatepasswordpage', (route) => false);
    }
  }, onError: (err) {
    debugPrint("Deep Link Error: $err");
  });
}

