import 'package:appdev/components/my_textfield.dart';
import 'package:flutter/material.dart';
//import 'package:tripmate/components/square_tile.dart';
import '../components/my_button.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerUser() {
    // Registration logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // Smooth scrolling
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
                // Logo
                const Icon(
                  Icons.person_add,
                  size: 100,
                  color: Colors.black,
                ),
            
                const SizedBox(height: 50),
            
                // Welcome text
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // Username field
                // MyTextField(
                //   controller: usernameController,
                //   hintText: 'Username',
                //   obscureText: false,
                // ),
            
                // const SizedBox(height: 10),
            
                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
            
                // Confirm Password field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                // Register button
                MyButton(
                  onTap: registerUser,
                ),
            
                const SizedBox(height: 50),
            
                // // Or continue with
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
            
                // const SizedBox(height: 50),
            
                // // Google sign in
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTile(imagePath: 'lib/images/google.png'),
                //     SizedBox(width: 25),
                //     SquareTile(imagePath: 'lib/images/google.png'),
                //   ],
                // ),
            
                const SizedBox(height: 50),
            
                // Already have an account? Sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
