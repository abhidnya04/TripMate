import 'package:flutter/material.dart';

class SavedModel {
  final String name;
  final Color boxColor;
  final String imagePath;
  

  SavedModel({
    required this.name,
    required this.imagePath,
    required this.boxColor,
  });

  static List<SavedModel> getCategories() {
    return [
      SavedModel(
        name: 'Delhi',
        imagePath: 'assets/d1.jpg',
        boxColor: Colors.white,

      ),
      SavedModel(
        name: 'Shimla',
        imagePath: 'assets/shm_f.png',
        boxColor: Colors.white,
      ),
      SavedModel(
        name: 'Goa',
        imagePath: 'assets/goa.jpg',
        boxColor: Colors.white,
      ),
      SavedModel(
        name: 'Kolkata',
        imagePath: 'assets/kol.jpg',
        boxColor: Colors.white,
      ),
    ];
  }
}
