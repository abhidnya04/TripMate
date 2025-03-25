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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Trips"),
        centerTitle: true,
      ),
      body: savedTrips.isEmpty
          ? const Center(child: Text("No trips saved yet."))
          : ListView.builder(
              itemCount: savedTrips.length,
              itemBuilder: (context, index) {
                final trip = savedTrips[index];
                return Card(
                  child: ListTile(
                    title: Text(trip['title'] ?? "Trip"),
                    
                    trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                      onPressed: () => _openPDF(trip['path']!),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
