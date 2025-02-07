import 'package:flutter/material.dart';


import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';


import 'register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  //text editing controllers

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
                  //logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  //   color: Colors.black,
                  //   ),
                  Image.asset(
                    'lib/images/TravelLuggage.png', // Update with your image path
                    height: 130, // Adjust size as needed
                    width: 130,
                    // Ensures proper scaling
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 40),

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterPage()), // Navigate to RegisterPage
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
      );
    });
  }
}






























// // Login Page

// // Created login page

// import 'package:appdev/components/my_textfield.dart';
// import 'package:flutter/material.dart';


// import '../components/my_button.dart';
// import '../components/square_tile.dart';


// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
  
//   //text editing controllers
 

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   void signUserIn(){

//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.grey[300],
//           body: Padding(
//             padding: EdgeInsets.fromLTRB(
//                     16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
//             child: SafeArea(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 50),
//                   //logo
//                   // const Icon(
//                   //   Icons.lock,
//                   //   size: 100,
//                   //   color: Colors.black,
//                   //   ),
//                   Image.asset(
//                       'lib/images/TravelLuggage.png', // Update with your image path
//                       height: 130, // Adjust size as needed
//                       width: 130,
//                        // Ensures proper scaling
//                     ),
                  
//                   const SizedBox(height: 50),
                    
//                   //welcom back,you've been missed
//                   Text(
//                     'Welcome back you\'ve been missed!',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 16,
//                     ),
                    
//                     ),
                
//                   const SizedBox(height: 25),
                    
//                   //username textfield
//                   MyTextField(
//                     controller: usernameController,
//                     hintText: 'Username',
//                     obscureText: false,
//                   ),
                    
//                   const SizedBox(height: 10),  
//                   //password textfield
//                   MyTextField(
//                     controller: passwordController,
//                     hintText: 'Password',
//                     obscureText: true,
//                   ),
            
//                   const SizedBox(height: 10),
                    
//                   //forgot password?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Forgot Password?',
//                           style: TextStyle(color: Colors.grey[600]),
//                           ),
//                       ],
//                     ),
//                   ),
            
//                   const SizedBox(height: 25),
                    
//                   //signin button
//                   MyButton(
//                     onTap: signUserIn,
//                   ),
            
//                   const SizedBox(height: 50),
                    
//                   //or countinue with
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Or continue with',
//                             style: TextStyle(color: Colors.grey[700]),
//                             ),
//                         ),
                  
//                         Expanded(
//                           child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                         ),
//                       ],
//                     ),
//                   ),
            
//                   const SizedBox(height: 50),          
                    
//                   //gooogle sign in
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SquareTile(imagePath: 'lib/images/google.png'),
//                       SizedBox(width: 25),
//                       SquareTile(imagePath: 'lib/images/google.png'),
                      
//                     ],
//                       ),
//                       const SizedBox(height: 50),
//                       //not a member>register
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Not a member?',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Register now',
//                             style: TextStyle(
//                               color: Colors.blue, fontWeight: FontWeight.bold),
//                             ),
            
//                       ],)
            
//                     ],
//                   )
                  
                    
                  
              
//                 ),
//               ),
//           ),
//           );
//       }
//     );
    
//   }
// }