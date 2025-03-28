import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile;
  final TextEditingController _fileNameController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) return;

    final user = _supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated. Please log in.')),
      );
      return;
    }

    final userId = user.id;
    final fileName = _fileNameController.text.trim();

    if (fileName.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid file name.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final filePath = '$userId/$fileName.jpg'; // Store under user ID folder

    try {
      await _supabase.storage
          .from('privatedoc')
          .upload(filePath, _imageFile!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload successful!')),
      );

      Navigator.pop(context, true); // Reload list after upload
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Upload Document')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, fit: BoxFit.cover, height: 300)
                : const Text('No file selected'),
            const SizedBox(height: 20),
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(labelText: "Enter file name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick File'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}

