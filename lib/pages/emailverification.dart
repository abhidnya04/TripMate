/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_registration/constants/routes.dart';

class Emailverificationview extends StatefulWidget {
  const Emailverificationview({super.key});

  @override
  State<Emailverificationview> createState() => _EmailverificationviewState();
}

class _EmailverificationviewState extends State<Emailverificationview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('email veification'),),
      body: Column(
            children: [
              const Text("If you havent recieved verification email click"),
              TextButton(
                onPressed: () async{
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                }, 
                child: const Text("send email verification code"),),
              TextButton(onPressed:() async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(loginroute, (route)=>false);
              }, child: const Text("log in"),)
            ],
          ),
    );
  }
}
*/