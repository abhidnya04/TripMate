import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LocalTripsPage extends StatefulWidget {
  @override
  _LocalTripsPageState createState() => _LocalTripsPageState();
}

class _LocalTripsPageState extends State<LocalTripsPage> {
  List<Map<String, String>> localTrips = [];

  @override
  void initState() {
    super.initState();
    _loadLocalTrips();
  }

  Future<void> _loadLocalTrips() async {
    try {
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
        localTrips = trips;
      });
    } catch (e) {
      print("Error loading local trips: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load local trips.")),
      );
    }
  }

  void _openPDF(String filePath) {
    OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloaded Trips", style: TextStyle(fontSize: 24)),
      ),
      body: localTrips.isEmpty
          ? const Center(child: Text("No downloaded trips found."))
          : ListView.builder(
              itemCount: localTrips.length,
              itemBuilder: (context, index) {
                final trip = localTrips[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
