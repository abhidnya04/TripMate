import 'package:appdev/components/deeplink.dart';
import 'package:appdev/components/forgetpassdialog.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
//import 'register.dart';

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
    String? _userId;
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
  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkUserSession(); // Check session at startup
  });
  // supabase.auth.onAuthStateChange.listen((data){
  //   setState(() {
  //     _userId=data.session?.user.id;
  //   });
  // });
  }

Future<void> checkUserSession() async {
  final session = supabase.auth.currentSession;
  print("Session: $session"); // Debugging
  
  if (session != null && session.user != null) {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/tabs'); // Navigate to home
    }
  } else {
    print("User is NOT logged in!");
  }
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
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: "com.example.appdev://login-callback", // Ensure it matches your package name
    );

    // Check session after successful login
    final session = supabase.auth.currentSession;
    if (session != null) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/tabs'); // Navigate to home
      }
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google Sign-In failed: $error')),
    );
    debugPrint('Google Sign-In Error: $error');
  }
}












// Future<void> _googleSignIn() async {
//   try {
//     const webClientId = '959813512476-31920amcqn6djdidshfm0mo816f1j4t6.apps.googleusercontent.com';
//     const iosClientId = '959813512476-o7jglqn6lct1k166thd3n09iit0cp35j.apps.googleusercontent.com';

//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       clientId: iosClientId,
//       serverClientId: webClientId,
//     );

//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       throw 'Google Sign-In canceled';
//     }

//     final googleAuth = await googleUser.authentication;
//     final accessToken = googleAuth.accessToken;
//     final idToken = googleAuth.idToken;

//     if (accessToken == null || idToken == null) {
//       throw 'Failed to get authentication tokens.';
//     }

//     final AuthResponse response = await supabase.auth.signInWithIdToken(
//       provider: OAuthProvider.google,
//       idToken: idToken,
//       accessToken: accessToken,
//     );

//     if (response.session != null) {
//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed('/tabs');
//       }
//     } else {
//       throw 'Authentication failed';
//     }
//   } catch (error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Login failed: $error')),
//     );
//     debugPrint('Google Sign-In Error: $error');
//   }
// }















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //const SizedBox(height: 5),

                 // Logo
                  Image.asset(
                    'lib/images/logo.png', 
                    height: 200,
                    width: 200,
                  ),
                  // Text('TripMate', style: GoogleFonts.pattaya(fontSize: 40, fontWeight: FontWeight.w500, color: Color(0xff03045e),
                  // ),),
                  const SizedBox(height: 6),

                  // Welcome text
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle( color: Color(0xff03045e), fontSize: 16),
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
                        style: TextStyle(color: Color(0xff03045e), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // login button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  25.0),
                    child: ElevatedButton(
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
                        child:  Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16), ),
                            ],
                          )),
                    
                        style: ElevatedButton.styleFrom(
                          // fixedSize: Size.infinite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Color(0xff03045e)
                        ),
                        ),
                  ),

                  const SizedBox(height: 30),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.5, color: Color(0xff03045e))),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Or continue with', style: TextStyle(color: Color(0xff03045e))),
                      ),
                      Expanded(child: Divider(thickness: 0.5, color: Color(0xff03045e))),
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
                      const Text('Not a member?', style: TextStyle(color: Color(0xff03045e))),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/signup',(route)=>false);
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(color:  Color(0xff03045e), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
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
