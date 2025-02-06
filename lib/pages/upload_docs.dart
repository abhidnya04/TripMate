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

    final filename = DateTime.now().microsecondsSinceEpoch.toString();
    final path = 'uploads/$filename';

    await Supabase.instance.client.storage
        // TO
        .from('Documents')
        .upload(path, _imagefile!)
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('succesful'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _imagefile != null
                    ? Image.file(_imagefile!)
                    : const Text('no file'),
            
                // buttin
                ElevatedButton(onPressed: pickImage, child: Text('Pick file')),
            
                ElevatedButton(onPressed: uploadImage, child: Text('uploadfile'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// gg
// klk