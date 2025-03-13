import 'package:appdev/components/forgetpassdialog.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool isLoading = false; // For showing a loading state

  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        configureDeepLink(context);
      }
    });
  });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  final supabase = Supabase.instance.client;
  Future<void> signInWithGoogle() async {
    try {
      await supabase.auth.signInWithOAuth(OAuthProvider.google);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  Image.asset(
                    'lib/images/TravelLuggage.png', 
                    height: 130,
                    width: 130,
                  ),
                  const SizedBox(height: 20),

                  // Welcome text
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 25),

                  // Username field
                  MyTextField(
                    controller:_email,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // Password field
                  MyTextField(
                    controller: _password,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // Forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                      onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ForgotPasswordDialog(),
                        );
                      },
                      child: const Text('Forgot Password?',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // login button
                  TextButton(
                    onPressed: () async {
                      print('hello');
                    final email = _email.text.trim();
                    final password = _password.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email and Password cannot be empty')),
                        );
                      return;
                      }

                    if (mounted) setState(() => isLoading = true);

                    try {
                      final response = await supabase.auth.signInWithPassword(
                      email: email,
                      password: password,
                      );

                      if (response.session != null) {
                      if (mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil('/tabs', (route) => false);
                        }
                      } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed: Invalid credentials')),
                      );
                      }
                      } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed: Invalid email or password')),
                      );
                      }

                      if (mounted) setState(() => isLoading = false); // ✅ Check mounted before calling setState
                      },
                      child: const Text('Login'),
                      ),

                  const SizedBox(height: 50),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Or continue with', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Google Sign-In
                  GestureDetector(
                    onTap: signInWithGoogle, // Attach Google Sign-In function
                    child: const SquareTile(imagePath: 'lib/images/google.png'),
                  ),
                  
                  const SizedBox(height: 50),

                  // Register option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/signup',(route)=>false);
                        },
                        child: const Text(
                          'Register now',
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
