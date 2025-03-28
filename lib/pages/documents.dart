
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'imageViewScreen.dart';

class MyDocuments extends StatefulWidget {
  const MyDocuments({super.key});

  @override
  State<MyDocuments> createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  bool _isLoading = true;
  List<FileObject> _loadedDocs = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final List<FileObject> docs = await Supabase.instance.client.storage
          .from('Documents')
          .list(path: 'uploads2');

      setState(() {
        _loadedDocs = docs;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading documents: $e");
    }
  }

  void removeItem(FileObject item) {
    setState(() {
      _loadedDocs.remove(item);
    });
  }

  void _navigateToUploadScreen() async {
    final result = await Navigator.pushNamed(context, '/uploadDocs');

    if (result == true) {
      _loadItems(); // ✅ Reload file list after upload
    }
  }

  void _openImage(String fileName) async {
    final imageUrl = Supabase.instance.client.storage
        .from('Documents')
        .getPublicUrl('uploads2/$fileName'); // ✅ Get file URL

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(imageUrl: imageUrl),
      ),
    );
  }

  void _shareDocument(String docName) {
    // Implement share functionality here
    print("Sharing: $docName");
  }

  void _deleteDocument(String docName) {
    // Implement delete functionality here
    print("Deleting: $docName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {},
          label: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.upload),
              Text('  Upload'),
            ],
          ),
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                foregroundColor: Color(0xff00296b),
          ),
        ),
        appBar: AppBar(
          title: Text('Your Documents', style: TextStyle(
                                  fontWeight:
                                      FontWeight.w500), ),
          actions: [
            IconButton(
              onPressed: _navigateToUploadScreen,
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _loadedDocs.isEmpty
                ? Center(child: Text('No items added yet'))
                : ListView.builder(
                    itemCount: _loadedDocs.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(_loadedDocs[index].id),
                      onDismissed: (direction) {
                        removeItem(_loadedDocs[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 6.0),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Shadow color
                                blurRadius: 8, // Softness of shadow
                                spreadRadius: 2, // How far the shadow spreads
                                offset:
                                    Offset(0, 4), // Vertical shadow direction
                              ),
                            ],
                          ),
                          // child: ListTile(
                          //   title: Text(
                          //     _loadedDocs[index].name,
                          //     style: TextStyle(
                          //         fontWeight:
                          //             FontWeight.w600), // Slightly bold text
                          //   ),
                          //   leading: Icon(Icons.insert_drive_file,
                          //       color: Colors.blueAccent), // File icon
                          //   tileColor: Colors.white,
                          //   onTap: () {
                          //     _openImage(_loadedDocs[index].name);
                          //   }, // Tile background color
                          // ),

                          child: ListTile(
                            title: Text(
                              _loadedDocs[index].name,
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600), // Slightly bold text
                            ),
                            leading: Icon(Icons.image_outlined,
                                color: Color(0xff00296b)), // File icon
                            tileColor: Color(0xffedf2fb), // Tile background color
                            onTap: () {
                              _openImage(_loadedDocs[index].name);
                            },
                            trailing: PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert), // Three dots icon
                              onSelected: (value) {
                                if (value == 'share') {
                                  _shareDocument(_loadedDocs[index].name);
                                } else if (value == 'delete') {
                                  _deleteDocument(_loadedDocs[index].name);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'share',
                                  child: Row(
                                    children: [
                                      Icon(Icons.share,
                                          color: Color(0xff00296b)),
                                      SizedBox(width: 8),
                                      Text('Share'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
  }
}
