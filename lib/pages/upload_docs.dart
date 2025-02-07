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
      body: Padding(
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
    );
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class UploadPage extends StatefulWidget {
//   const UploadPage({super.key});

//   @override
//   State<UploadPage> createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   final SupabaseClient _supabase = Supabase.instance.client;
//   List<Map<String, String>> _uploadedImages = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchUploadedImages();
//   }

//   Future pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _imageFile = File(image.path);
//       });
//       _showCaptionDialog();
//     }
//   }

//   Future uploadImage(String caption) async {
//     if (_imageFile == null) return;

//     final filename = "${DateTime.now().microsecondsSinceEpoch}.jpg";
//     final path = 'uploads/$filename';

//     try {
//       await _supabase.storage.from('Documents').upload(path, _imageFile!);
//       final url = _supabase.storage.from('Documents').getPublicUrl(path);
      
//       await _supabase.from('images').insert({
//         'url': url,
//         'caption': caption,
//       });

//       setState(() {
//         _uploadedImages.add({'url': url, 'caption': caption});
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
//     }
//   }

//   Future fetchUploadedImages() async {
//     final response = await _supabase.from('Documents').select('url, caption');
//     setState(() {
//       _uploadedImages = List<Map<String, String>>.from(response);
//     });
//   }

//   void _showCaptionDialog() {
//     TextEditingController captionController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Enter Caption"),
//           content: TextField(controller: captionController),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 uploadImage(captionController.text);
//               },
//               child: const Text("Upload"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Uploaded Images")),
//       body: ListView.builder(
//         itemCount: _uploadedImages.length,
//         itemBuilder: (context, index) {
//           final image = _uploadedImages[index];
//           return ListTile(
//             leading: Image.network(image['url']!, width: 50, height: 50, fit: BoxFit.cover),
//             title: Text(image['caption']!),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ImageViewScreen(url: image['url']!, caption: image['caption']!),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ImageViewScreen extends StatelessWidget {
//   final String url;
//   final String caption;

//   const ImageViewScreen({super.key, required this.url, required this.caption});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(caption)),
//       body: Center(child: Image.network(url)),
//     );
//   }
// }
