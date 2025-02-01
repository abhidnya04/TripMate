import 'package:flutter/material.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("CREATE")),
    );
  }
}