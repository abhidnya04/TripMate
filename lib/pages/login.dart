// Login Page

// Created login page

import 'package:appdev/components/my_textfield.dart';
import 'package:flutter/material.dart';


import '../components/my_button.dart';
import '../components/square_tile.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});
  
  //text editing controllers
 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
              color: Colors.black,
              ),
            
            const SizedBox(height: 50),
              
            //welcom back,you've been missed
            Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
              
              ),
          
            const SizedBox(height: 25),
              
            //username textfield
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
              
            const SizedBox(height: 10),  
            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),
              
            //forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 25),
              
            //signin button
            MyButton(
              onTap: signUserIn,
            ),

            const SizedBox(height: 50),
              
            //or countinue with
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                      ),
                  ),
            
                  Expanded(
                    child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),          
              
            //gooogle sign in
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/images/google.png'),
                SizedBox(width: 25),
                SquareTile(imagePath: 'lib/images/google.png'),
                
              ],
                ),
                const SizedBox(height: 50),
                //not a member>register
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                      ),

                ],)

              ],
            )
            
              
            
        
          ),
        ),
      );
    
  }
}