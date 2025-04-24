import 'package:appdev/components/logoutalert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'components/articles_widget.dart';
import 'components/saved_thumbnails.dart';
import 'models/articles.dart';
import 'models/saved.dart';
import 'pages/tabs.dart';

// import 'saved_itineraries.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  late List<SavedModel> categories;
  late List<ArticleModel> articles;

  @override
  void initState() {
    super.initState();
    categories = SavedModel.getCategories();
    articles = ArticleModel.getArticles();
  }

  final supabase = Supabase.instance.client;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(size: 30),
//         // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         actions:  [
//           GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => logotalert(),
//               );
//             },
//             child: Icon(Icons.person_4))
//           ],
//         centerTitle: true,
//         title: const Text("TripMate", style: TextStyle(fontWeight: FontWeight.w500),),
//         leading: GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => logotalert(),
//               );
//             },
//             child: const Icon(Icons.view_sidebar_outlined)),
//       ),
//       body: ListView(
//         children: [
//           GreetContainer(),
//           SavedItineraries(categories: categories),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Travel Stories",
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   "Top stories from around the world!",
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w300),
//                 ),
//                 ArticlesWidget(articles: articles),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
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
        title: Text("TripMate",
            style:
                GoogleFonts.pattaya(fontWeight: FontWeight.w500, fontSize: 32)),
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
      drawer: customdrawer(),
  //     body: Stack(
  //       // fit: ,
  //       children: [
  //         // Background Greeting Section
  //         GreetContainer(),

  //         // Foreground Card Section
  //         Positioned(
  //           top:
  //               MediaQuery.of(context).size.height * 0.23, // Adjust for overlap
  //           left: 0.001,
  //           right: 0.001,
  //           child: Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //             elevation: 8, // Adds shadow for depth
  //             child: Padding(
  //               padding: const EdgeInsets.all(0.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     height: 16,
  //                   ),
  //                   SavedItineraries(categories: categories),
  //                   const Padding(
  //                     padding: EdgeInsets.only(left: 20.0),
  //                     child: Text(
  //                       "Travel Stories",
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.only(left: 20.0),
  //                     child: Text(
  //                       "Top stories from around the world!",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w300,
  //                       ),
  //                     ),
  //                   ),
  //                   ArticlesWidget(articles: articles),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),

  body: CustomScrollView(
      slivers: [
        SliverAppBar(
            automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          expandedHeight: 200.0,
          pinned: false,
          floating: false,

          flexibleSpace: FlexibleSpaceBar(
            background: GreetContainer(), // 👈 Your greeting
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SavedItineraries(categories: categories),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Travel Stories",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Top stories from around the world!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    ArticlesWidget(articles: articles),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }

  Padding GreetContainer() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
          Color(0xffccdbfd),
          Color(0xffcaf0f8),
        ])),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Hello Voyager 👋',
              style:
                  GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Ready for your next adventure?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TabsScreen(initialIndex: 2)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffccdbfd),
                  foregroundColor: Color(0xff03045e),
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Create trip with AI  '),
                    // Icon(Icons.maps_ugc_outlined)
                    Image.asset(
                      'assets/wand.png',
                      height: 30,
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
