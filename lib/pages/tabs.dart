import 'package:appdev/components/logoutalert.dart';
import 'package:appdev/pages/create_trip.dart';
import 'package:appdev/pages/documents.dart';
import 'package:appdev/pages/offline.dart';
import 'package:appdev/pages/translate.dart';
import 'package:appdev/pages/your_trips.dart';
 import 'package:appdev/components/logoutalert.dart';
import 'package:appdev/trip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> _fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final response =
        await supabase.from('profiles').select().eq('id', user.id).single();

    return response;
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
      appBar: AppBar(
      iconTheme: const IconThemeData(size: 30),
      actions: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => logotalert(),
            );
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
    drawer: CustomDrawer(),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.translate_outlined), label: 'Translate'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'New Trip'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Your trips'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'DocVault'),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<Map<String, dynamic>?> _fetchUserProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final response =
        await supabase.from('profiles').select().eq('id', user.id).single();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final profile = snapshot.data;
          final username = profile?['Display name'] ?? 'User';
          // final username = profile?['Display name'] ?? 'User';
          // final username = Supabase.instance.client.auth.currentUser? ?? '';

          final email = Supabase.instance.client.auth.currentUser?.email ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // UserAccountsDrawerHeader(
              //   accountName: Text(username,style: TextStyle(color: Colors.black)),
              //   accountEmail: Text(email, style: TextStyle(color: Colors.black),),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundColor: Colors.white,
              //     child: Text(
              //       username.isNotEmpty ? username[0].toUpperCase() : '?',
              //       style: TextStyle(fontSize: 30.0, color: Colors.blue),
              //     ),
              //   ),
              //   decoration: BoxDecoration(color: Color(0xffcaf0f8)),
              // ),
              Container(
                width: double.infinity,
                color: Color(0xffccdbfd),
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      // child: Text(
                      //   username.isNotEmpty ? username[0].toUpperCase() : '?',
                      //   style: const TextStyle(fontSize: 30.0, color: Colors.blue),
                      // ),
                      child: Image.asset('assets/traveller.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.download),
                title: Text('View Downloads',),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocalTripsPage()));
                },
              ),
ListTile(
  leading: Icon(Icons.book_rounded),
  title: Text('Travel Blogs'),
  onTap: () {
                  Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Travel Blogs - To be implemented soon!'),
      ),
    );
  },
),

              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red,),
                title: Text('Logout' , style: TextStyle(color: Colors.red),),
                onTap: () {
                  // await Supabase.instance.client.auth.signOut();
                  Navigator.pop(context);
                  // Optionally navigate to login screen
                  showDialog(
                      context: context,
                      builder: (context) => logotalert(),
                    );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

// class customdrawer extends StatelessWidget {
//   const customdrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color(0xffcaf0f8),
//             ),
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 '👋 Hello, User!',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.download),
//             title: Text('View Downloads'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigator.pushNamed(context, '/downloads');

//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigator.pushNamed(context, '/settings');
//             },
//           ),
//           Spacer(),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               // Add your logout logic here
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
