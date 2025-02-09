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
      appBar: AppBar(
        title: const Text(
          'Travel Preferences',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          ),
      ),
      body: Center(child: Text("CREATE")),
    );
  }
}