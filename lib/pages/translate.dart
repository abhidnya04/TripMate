import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = "";

  String _inputLanguage = "English";
  String _outputLanguage = "French";

  // Supported languages map
  final Map<String, TranslateLanguage> _languageMap = {
    "English": TranslateLanguage.english,
    "French": TranslateLanguage.french,
    "Spanish": TranslateLanguage.spanish,
    "German": TranslateLanguage.german,
    "Hindi": TranslateLanguage.hindi,
    "Chinese": TranslateLanguage.chinese,
  };

  final Map<String, String> _languageFlags = {
  "English": "🇬🇧",
  "French": "🇫🇷",
  "Spanish": "🇪🇸",
  "German": "🇩🇪",
  "Hindi": "🇮🇳",
  "Chinese": "🇨🇳",
  };


  Future<void> translateText() async {
    if (_textController.text.isEmpty) return;

    try {
      final translator = OnDeviceTranslator(
        sourceLanguage: _languageMap[_inputLanguage]!,
        targetLanguage: _languageMap[_outputLanguage]!,
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
        title: Text("Translator"),
        backgroundColor: Colors.lightGreen[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input Text Container
              _buildLabel("Input Text"),
              _buildTranslationContainer(
                dropdownValue: _inputLanguage,
                onChanged: (newValue) => setState(() => _inputLanguage = newValue!),
                controller: _textController,
                hintText: "Enter text to translate...",
                isEditable: true,
              ),
        
              SizedBox(height: 20),
        
              // Output Translated Text Container
              _buildLabel("Translated Text"),
              _buildTranslationContainer(
                dropdownValue: _outputLanguage,
                onChanged: (newValue) => setState(() => _outputLanguage = newValue!),
                text: _translatedText,
                isEditable: false,
              ),
        
              SizedBox(height: 20),
        
              // Translate Button
              ElevatedButton(
                onPressed: translateText,
                child: Text("Translate", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build section labels
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Function to build the translation container with a dropdown
  Widget _buildTranslationContainer({
    required String dropdownValue,
    required void Function(String?) onChanged,
    TextEditingController? controller,
    String? text,
    required bool isEditable,
    String? hintText,
  }) {
    return Container(
      height: 200,
      width: 600,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown for selecting language
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.lightGreen[300],
              borderRadius: BorderRadius.circular(12),
            ),
            // child: DropdownButton<String>(
            //   value: dropdownValue,
            //   dropdownColor: Colors.black,
            //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   underline: SizedBox(),
            //   icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            //   items: _languageMap.keys.map((String lang) {
            //     return DropdownMenuItem(value: lang, child: Text(lang));
            //   }).toList(),
            //   onChanged: onChanged,
            // ),
            child: DropdownButton<String>(
  value: dropdownValue,
  dropdownColor: Colors.lightGreen[300],
  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  underline: SizedBox(),
  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
  items: _languageMap.keys.map((String lang) {
    return DropdownMenuItem(
      value: lang,
      child: Row(
        children: [
          Text(_languageFlags[lang] ?? ""), // Display flag
          SizedBox(width: 10), // Spacing
          Text(lang),
        ],
      ),
    );
  }).toList(),
  onChanged: onChanged,
),

          ),

          SizedBox(height: 10),

          // Input TextField or Translated Text
          isEditable
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                )
              : Text(
                  text ?? "Translation appears here...",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
        ],
      ),
    );
  }
}
