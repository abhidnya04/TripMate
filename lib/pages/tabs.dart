import 'package:appdev/pages/create_trip.dart';
import 'package:appdev/pages/documents.dart';
import 'package:appdev/pages/translate.dart';
import 'package:appdev/pages/your_trips.dart';
// import 'package:appdev/pages/upload_docs.dart';
import 'package:appdev/trip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class TabsScreen extends StatefulWidget {
//   static final GlobalKey<_TabsScreenState> tabsKey = GlobalKey<_TabsScreenState>();
//   const TabsScreen({super.key});

//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   int _selectedPageIndex = 0;

//   void selectPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget activePage = Trip();

//     if (_selectedPageIndex == 1) {
//       activePage = TranslationPage();
//     } else if (_selectedPageIndex == 2) {
//       activePage = CreateTrip();
//     } else if (_selectedPageIndex == 3) {
//       activePage = YourTripsPage();
//     } else if (_selectedPageIndex == 4) {
//       activePage = MyDocuments();
//     }

//     return Scaffold(
//       // appBar: AppBar(),
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//           selectedIconTheme: IconThemeData(color: Color(0xff03045e)),
//           unselectedIconTheme: IconThemeData(color: Color(0xff9381ff)),
//           selectedItemColor: Color(0xff03045e), // Change to your desired color
//           unselectedItemColor: Color(0xff9381ff),
//           selectedLabelStyle: TextStyle(
//               fontWeight: FontWeight.bold), // Bold text for selected item
//           unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
//           // backgroundColor: Colors.white,
//           onTap: (int index) {
//             selectPage(index);
//           },
//           currentIndex: _selectedPageIndex,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.explore,
//               ),
//               backgroundColor: Color(0xffedf2fb),
//               label: 'Explore',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.translate_outlined),
//               label: 'Translate',
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.create), label: 'New Trip'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_bag), label: 'Your trips'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.upload), label: 'DocVault'),
//           ]),
//     );
//   }
// }


class TabsScreen extends StatefulWidget {
  final int initialIndex;

  const TabsScreen({super.key, this.initialIndex = 0});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.initialIndex; // Set initial tab index
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = Trip();

    if (_selectedPageIndex == 1) {
      activePage = TranslationPage();
    } else if (_selectedPageIndex == 2) {
      activePage = CreateTrip();
    } else if (_selectedPageIndex == 3) {
      activePage = YourTripsPage();
    } else if (_selectedPageIndex == 4) {
      activePage = MyDocuments();
    }

    return Scaffold(
      appBar: _selectedPageIndex == 0 ? null :
      
      AppBar(
      iconTheme: const IconThemeData(size: 30),
      actions: [
        GestureDetector(
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (context) => logotalert(),
            // );
          },
          child: Icon(Icons.person_4),
        )
      ],
      centerTitle: true,
      title:  Text("TripMate", style: GoogleFonts.pattaya(fontWeight: FontWeight.w500, fontSize: 32)),
      // leading: GestureDetector(
      //   onTap: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) => logotalert(),
      //     );
      //   },
      //   child: const Icon(Icons.view_sidebar_outlined),
      // ),
      // leading: Drawer(),
      
    ),
    drawer: Drawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Color(0xff03045e)),
        unselectedIconTheme: IconThemeData(color: Color(0xff9381ff)),
        selectedItemColor: Color(0xff03045e),
        unselectedItemColor: Color(0xff9381ff),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        onTap: (int index) {
          selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.translate_outlined), label: 'Translate'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'New Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Your trips'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'DocVault'),
        ],
      ),
    );
  }
}
