import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = "Translation will appear here...";

  Future<void> translateText() async {
    if (_textController.text.isEmpty) return;

    try {
      final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english, // Source: English
        targetLanguage: TranslateLanguage.french, // Target: French
      );

      final translatedText = await translator.translateText(_textController.text);
      setState(() {
        _translatedText = translatedText;
      });
    } catch (e) {
      setState(() {
        _translatedText = "Error: ${e.toString()}";
      });
      print("Translation Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Translator")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: translateText,
              child: Text("Translate"),
            ),
            SizedBox(height: 16),
            Text(
              "Translated Text:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              _translatedText,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
