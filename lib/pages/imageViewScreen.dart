import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview")),
      body: Center(
        child: imageUrl.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(imageUrl, fit: BoxFit.contain, height: 800,),
            ) // ✅ Display image from URL
            : CircularProgressIndicator(),
      ),
    );
  }
}
