import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_registration/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
            ), 
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return Column(
            children:[ 
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your Email',
              ),
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextButton(
              onPressed: () async{
                final email=_email.text;
                final password=_password.text;
                try {
                  final userCredential=await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: email, 
                    password: password
                    );
                    print(userCredential); 
                }
                on FirebaseAuthException catch(e) {
                 if(e.code=='invalid-email'){
                  print("user id not found");
                 }
                 else if(e.code=='invalid-password'){
                  print("wrong password");
                 }
                 else{
                  print("invalid credentials check your password and username");
                 }
                }
              },
              child: const Text('Login'),
              ),
            ],
          );
          default : 
          return const Text(" Loading .......");
        }  
        },
      ),
    );
  }
}