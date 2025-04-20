import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'imageViewScreen.dart';
import 'dart:io';


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
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      print("User not logged in");
      return;
    }

    try {
      final List<FileObject> docs = await Supabase.instance.client.storage
          .from('privatedoc')
          .list(path: userId); // ✅ List only the user's files

      setState(() {
        _loadedDocs = docs;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading documents: $e");
    }
  }

  void removeItem(FileObject item) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
      return;
    }

    final filePath = '${user.id}/${item.name}'; // Ensure correct file path

    try {
      await Supabase.instance.client.storage
          .from('privatedoc')
          .remove([filePath]); // 🗑 Delete file from storage

      setState(() {
        _loadedDocs.remove(item); // ✅ Remove from local list
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File deleted successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting file: $e')),
      );
    }
  }

  void _navigateToUploadScreen() async {
    final result = await Navigator.pushNamed(context, '/uploadDocs');

    if (result == true) {
      _loadItems(); // ✅ Reload file list after upload
    }
  }

void _shareDocument(String docName) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;

  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User not logged in')),
    );
    return;
  }

  try {
    // 1. Generate signed URL to download file
    final signedUrl = await Supabase.instance.client.storage
        .from('privatedoc')
        .createSignedUrl('$userId/$docName', 3600);

    // 2. Download file content
    final response = await http.get(Uri.parse(signedUrl));
    if (response.statusCode != 200) {
      throw Exception("Failed to download file");
    }

    // 3. Get local path to save file
    final tempDir = await getTemporaryDirectory();
    final localFilePath = '${tempDir.path}/$docName';

    final file = File(localFilePath);
    await file.writeAsBytes(response.bodyBytes);

    // 4. Share file
    await Share.shareXFiles([XFile(file.path)], text: 'Sharing $docName');

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error sharing document: $e')),
    );
  }
}

void _deleteDocument(String docName) async {
  FileObject? itemToDelete;
  for (final doc in _loadedDocs) {
    if (doc.name == docName) {
      itemToDelete = doc;
      break;
    }
  }

  if (itemToDelete == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Document not found.')),
    );
    return;
  }

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Document'),
      content: const Text('Are you sure you want to delete this document?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );

  if (confirm == true) {
    removeItem(itemToDelete);
  }
}


  void _openImage(String fileName) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      print("User not logged in");
      return;
    }

    final imageUrl = await Supabase.instance.client.storage
        .from('privatedoc')
        .createSignedUrl(
            '$userId/$fileName', 60); // ✅ Secure access with signed URL

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ' My Uploaded documents',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Color(0xff00296b)
          ),
onPressed: _navigateToUploadScreen,

            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.upload),
                Text('Upload'),
              ],
            )),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _loadedDocs.isEmpty
                ? Center(child: Text('No items added yet'))
                : ListView.builder(
                    itemCount: _loadedDocs.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(_loadedDocs[index].id),
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
                          child: ListTile(
                            leading: Icon(Icons.image_outlined,
                                color: Color(0xff00296b)), // File icon
                            tileColor:
                                Color(0xffedf2fb), // Tile background color
                            title: Text(
                              _loadedDocs[index].name,
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600), // Slightly bold text
                            ),
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
