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
  @override
  File? _imagefile;
  final TextEditingController _fileNameTextEditingController =
      TextEditingController();

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagefile = File(image.path);
      });
    }
  }

  Future uploadImage() async {
    if (_imagefile == null) return;

    if (_fileNameTextEditingController.text.trim().isEmpty) {
      //error
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please enter valid data'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('okay'))
                ],
              ));
      return;
    }

    final filename = _fileNameTextEditingController.text;
    // final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads2/$filename';

    await Supabase.instance.client.storage
        // TO
        .from('Documents')
        .upload(path, _imagefile!)
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('succesful'))));

    // Navigator.popAndPushNamed(context, '/myDocs');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(42.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _imagefile != null
                    ? Image.file(
                        _imagefile!,
                        fit: BoxFit.cover,
                        height: 500,
                      )
                    : const Text('no file'),
        
                // buttin
        
                TextField(
                  controller: _fileNameTextEditingController,
                  decoration: InputDecoration(helperText: "Enter file name"),
                ),
                ElevatedButton(onPressed: pickImage, child: Text('Pick file')),
        
                ElevatedButton(onPressed: uploadImage, child: Text('uploadfile')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


