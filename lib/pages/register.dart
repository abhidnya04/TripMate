import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/my_textfield.dart';
import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmpassword;

@override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    _confirmpassword=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  final supabase = Supabase.instance.client;

  // Future<void> registerUser() async {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //   final confirmPassword = confirmPasswordController.text.trim();

    // if (password != confirmPassword) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Passwords do not match")),
    //   );
    //   return;
    // }

    // try {
    //   final response = await Supabase.instance.client.auth.signUp(
    //     email: email,
    //     password: password,
    //   );

    //   if (response.user != null) {
    //     // Successful registration
    //     if (mounted) {
    //       Navigator.pushReplacementNamed(context, '/login');
    //     }
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Registration successful! Please verify your email.")),
    //     );
    //   }
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Registration failed: $error")),
    //   );
    // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16, 
                right: 16, 
                top: 16, 
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.person_add, size: 100, color: Colors.black),
                  const SizedBox(height: 50),
                  Text(
                    'Create an account',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 25),

                  MyTextField(controller: _email, hintText: 'Email', obscureText: false),
                  const SizedBox(height: 10),
                  
                  MyTextField(controller: _password, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 10),
                  
                  MyTextField(controller: _confirmpassword, hintText: 'Confirm Password', obscureText: true),
                  const SizedBox(height: 25),

                  TextButton(onPressed: () async{
                    final email = _email.text.trim();
                    final password = _password.text.trim();
                    final confirmpassword = _confirmpassword.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email and Password cannot be empty')),
                      );
                      return;
                    }

                    if (password != confirmpassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                        try {
                          final response = await supabase.auth.signUp(
                          email: email,
                          password: password,
                          );

                          if (response.user != null) {
                          // Successful registration
                          if (mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil('/login',(route)=>false);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registration successful! Please verify your email.")),
                          );
                          }
                          } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Registration failed: $error")),
                          );
                          }

                  },
                   child: const Text('signup')),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/login',(route)=>false);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
