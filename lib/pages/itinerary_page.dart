import 'package:flutter/material.dart';

class ItineraryPage extends StatelessWidget {
  final String itinerary;

  const ItineraryPage({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generated Itinerary")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(itinerary, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
