import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import '../components/language_container.dart';
import '../utils/languages.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = "";

  String _inputLanguage = "English";
  String _outputLanguage = "French";

  Future<void> translateText() async {
    if (_textController.text.isEmpty) return;

    try {
      final translator = OnDeviceTranslator(
        sourceLanguage: languageMap[_inputLanguage]!,
        targetLanguage: languageMap[_outputLanguage]!,
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
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: const Text("Translator"),
        backgroundColor: Colors.lightGreen[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input Text Container
              _buildLabel("Input Text"),
              TranslationContainer(
                dropdownValue: _inputLanguage,
                onChanged: (newValue) => setState(() => _inputLanguage = newValue!),
                controller: _textController,
                hintText: "Enter text to translate...",
                isEditable: true,
              ),

              const SizedBox(height: 20),

              // Output Translated Text Container
              _buildLabel("Translated Text"),
              TranslationContainer(
                dropdownValue: _outputLanguage,
                onChanged: (newValue) => setState(() => _outputLanguage = newValue!),
                text: _translatedText,
                isEditable: false,
              ),

              const SizedBox(height: 20),

              // Translate Button
              ElevatedButton(
                onPressed: translateText,
                child: const Text("Translate", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
