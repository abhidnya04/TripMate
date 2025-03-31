// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class YourTripsPage extends StatefulWidget {
//   @override
//   _YourTripsPageState createState() => _YourTripsPageState();
// }

// class _YourTripsPageState extends State<YourTripsPage> {
//   List<Map<String, String>> savedTrips = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedTrips();
//   }

//   Future<void> _loadSavedTrips() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final List<FileSystemEntity> files = directory.listSync();

//     List<Map<String, String>> trips = files
//         .where((file) => file.path.endsWith('.pdf'))
//         .map((file) => {
//               'title': file.uri.pathSegments.last.replaceAll('.pdf', ''),
//               'path': file.path,
//             })
//         .toList();

//     setState(() {
//       savedTrips = trips;
//     });
//   }

//   void _openPDF(String filePath) {
//     OpenFile.open(filePath);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Trips", style: TextStyle(fontSize: 24),),
//         // centerTitle: true,
//       ),
//       body: savedTrips.isEmpty
//           ? const Center(child: Text("No trips saved yet."))
//           : ListView.builder(
//               itemCount: savedTrips.length,
//               itemBuilder: (context, index) {
//                 final trip = savedTrips[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(trip['title'] ?? "Trip"),
                    
//                     trailing: IconButton(
//                       icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
//                       onPressed: () => _openPDF(trip['path']!),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class YourTripsPage extends StatefulWidget {
//   @override
//   _YourTripsPageState createState() => _YourTripsPageState();
// }

// class _YourTripsPageState extends State<YourTripsPage> {
//   List<Map<String, String>> savedTrips = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedTrips();
//   }

//   Future<void> _loadSavedTrips() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final List<FileSystemEntity> files = directory.listSync();

//     List<Map<String, String>> trips = files
//         .where((file) => file.path.endsWith('.pdf'))
//         .map((file) => {
//               'title': file.uri.pathSegments.last.replaceAll('.pdf', ''),
//               'path': file.path,
//             })
//         .toList();

//     setState(() {
//       savedTrips = trips;
//     });
//   }

//   void _openPDF(String filePath) {
//     OpenFile.open(filePath);
//   }

//   void _manageBudget(String tripTitle) {
//     // Navigate to budget management page (to be implemented)
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Manage budget for $tripTitle")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Trips", style: TextStyle(fontSize: 24)),
//       ),
//       body: savedTrips.isEmpty
//           ? const Center(child: Text("No trips saved yet."))
//           : ListView.builder(
//               itemCount: savedTrips.length,
//               itemBuilder: (context, index) {
//                 final trip = savedTrips[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     child: ExpansionTile(
//                                           tilePadding:  EdgeInsets.zero,
//                     maintainState: true,
//                       title: Text(trip['title'] ?? "Trip"),
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () => _openPDF(trip['path']!),
//                               child: const Text("Show PDF"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () => _manageBudget(trip['title']!),
//                               child: const Text("Manage Budget"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class YourTripsPage extends StatefulWidget {
  @override
  _YourTripsPageState createState() => _YourTripsPageState();
}

class _YourTripsPageState extends State<YourTripsPage> {
  List<Map<String, String>> savedTrips = [];

  @override
  void initState() {
    super.initState();
    _loadSavedTrips();
  }

  Future<void> _loadSavedTrips() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    List<Map<String, String>> trips = files
        .where((file) => file.path.endsWith('.pdf'))
        .map((file) => {
              'title': file.uri.pathSegments.last.replaceAll('.pdf', ''),
              'path': file.path,
            })
        .toList();

    setState(() {
      savedTrips = trips;
    });
  }

  void _openPDF(String filePath) {
    OpenFile.open(filePath);
  }

  void _manageBudget(String tripTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Manage budget for $tripTitle")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Trips", style: TextStyle(fontSize: 24)),
      ),
      body: savedTrips.isEmpty
          ? const Center(child: Text("No trips saved yet."))
          : ListView.builder(
              itemCount: savedTrips.length,
              itemBuilder: (context, index) {
                final trip = savedTrips[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    
                    collapsedShape: RoundedRectangleBorder(),
                    initiallyExpanded: false,

                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    maintainState: true,
                    title: Text(trip['title'] ?? "Trip", style: TextStyle(fontSize: 20),),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              onPressed: () => _openPDF(trip['path']!),
                              child: const Text("Show PDF"),
                            ),
                            ElevatedButton(
                              onPressed: () => _manageBudget(trip['title']!),
                              child: const Text("Manage Budget"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
