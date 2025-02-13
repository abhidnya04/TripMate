/*

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:learn_registration/constants/routes.dart';
import 'package:learn_registration/utilities/dialog.dart';

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
      appBar: AppBar(title: const Text('Login '),),
      body: Column(
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
                    await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: email, 
                      password: password
                      );
                      final user = FirebaseAuth.instance.currentUser;
                      if(user?.emailVerified ?? false){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                        notesroute,
                        (route)=>false,
                        );
                      }
                      else{
                        Navigator.of(context).pushNamedAndRemoveUntil(
                        emailverification,
                        (route)=>false,
                        );
                      }
                  }
                  on FirebaseAuthException catch(e) {
                   if(e.code=='invalid-email'){
                    await showerrorDialog(context, 'user id not found');
                   }
                   else if(e.code=='invalid-password'){
                    await showerrorDialog(context, 'wrong credentials');
                   }
                   else{
                    await showerrorDialog(context, 'error ${e.code}');
                   }
                  } catch(e){
                    await showerrorDialog(context, e.toString());
                  }
                },
                child: const Text('Login'),
                ),
                TextButton(
                  onPressed:(){
                    Navigator.of(context).pushNamedAndRemoveUntil(registerroute, (route)=>false);
                  }, 
                  child: const Text("dont have an account yet ? register")
                  ),
              ],
            ),
    );
  }
}

*/