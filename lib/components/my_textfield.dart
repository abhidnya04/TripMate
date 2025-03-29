import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context){
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                // style: TextFormField(),
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff03045e), width: 2),
                  ),
                  fillColor: Color(0xffffffff),
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            );
  }
}