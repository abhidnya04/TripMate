import 'package:appdev/pages/create_trip.dart';
import 'package:appdev/pages/documents.dart';
import 'package:appdev/pages/translate.dart';
// import 'package:appdev/pages/upload_docs.dart';
import 'package:appdev/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'manage_trips.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = Trip();

    if (_selectedPageIndex == 1) {
      activePage = TranslatePage();
    } else if (_selectedPageIndex == 2) {
      activePage = CreateTrip();
    } else if (_selectedPageIndex == 3) {
      activePage = ManageTrips();
    } else if (_selectedPageIndex == 4) {
      activePage = MyDocuments();
    }

    return Scaffold(
      // appBar: AppBar(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.white,
          onTap: (int index) {
            selectPage(index);
          },
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.explore), backgroundColor: Color.fromARGB(255, 113, 174, 239), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.translate_outlined),backgroundColor: Color.fromARGB(255, 115, 155, 132) , label: 'Translate',),
            BottomNavigationBarItem(icon: Icon(Icons.create),backgroundColor: Color.fromARGB(255, 113, 174, 239) ,  label: 'New Trip'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),backgroundColor: Color.fromARGB(255, 113, 174, 239) ,  label: 'Your trips'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload), backgroundColor: Color.fromARGB(255, 113, 174, 239) , label: 'DocVault'),
          ]),
    );
  }
}
