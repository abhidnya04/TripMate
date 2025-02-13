/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_registration/constants/routes.dart';
import 'package:learn_registration/utilities/dialog.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {

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
                try{
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password);
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                        emailverification,
                        (route)=>false,
                        );
                }
                on FirebaseAuthException catch(e){
                  if(e.code=='invalid-email'){
                    await showerrorDialog(context, 'wrong email');
                  }
                  if(e.code=='weak-password'){
                    await showerrorDialog(context, 'weak password');
                  }
                  if(e.code=='email-already-in-use'){
                    await showerrorDialog(context, 'email is already registered');
                  }
                  else{
                    await showerrorDialog(context, '${e.code}');
                    }
                }catch(e){
                  await showerrorDialog(context, e.toString());
                }
              },
              child: const Text('register'),
              ),
              TextButton(
                onPressed:(){
                  Navigator.of(context).pushNamedAndRemoveUntil(loginroute, (route)=>false);
                }, 
                child: const Text("Already have a account ? login")
                ),
            ],
          )
    );
  }
}

*/