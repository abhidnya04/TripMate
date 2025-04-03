import 'package:flutter/material.dart';

// class SavedModel {
//   final String name;
//   final Color boxColor;
//   final String imagePath;


//   SavedModel({
//     required this.name,
//     required this.imagePath,
//     required this.boxColor,
//   });

//   static List<SavedModel> getCategories() {
//     return [
//       SavedModel(
//         name: 'Delhi',
//         imagePath: 'assets/d1.jpg',
//         boxColor: Colors.white,

//       ),
//       SavedModel(
//         name: 'Shimla',
//         imagePath: 'assets/shm_f.png',
//         boxColor: Colors.white,
//       ),
//       SavedModel(
//         name: 'Goa',
//         imagePath: 'assets/goa.jpg',
//         boxColor: Colors.white,
//       ),
//       SavedModel(
//         name: 'Kolkata',
//         imagePath: 'assets/kol.jpg',
//         boxColor: Colors.white,
//       ),
//     ];
//   }
// }


class SavedModel {
  final String name;
  final Color boxColor;
  final String imagePath;
  final String route;

  SavedModel({
    required this.name,
    required this.imagePath,
    required this.boxColor,
    required this.route,
  });

  static List<SavedModel> getCategories() {
    return [
      SavedModel(
        name: 'Delhi',
        imagePath: 'assets/d1.jpg',
        boxColor: Colors.white,
        route: '/delhi',
      ),
      SavedModel(
        name: 'Shimla',
        imagePath: 'assets/shm_f.png',
        boxColor: Colors.white,
        route: '/shimla',
      ),
      SavedModel(
        name: 'Goa',
        imagePath: 'assets/goa.jpg',
        boxColor: Colors.white,
        route: '/goa',
      ),
      SavedModel(
        name: 'Kolkata',
        imagePath: 'assets/kol.jpg',
        boxColor: Colors.white,
        route: '/kolkata',
      ),
    ];
  }
}
