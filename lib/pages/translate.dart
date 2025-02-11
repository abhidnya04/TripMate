import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = "";

  String _inputLanguage = "English"; // Default input language
  String _outputLanguage = "French"; // Default output language

  // Language Map for ML Kit
  final Map<String, TranslateLanguage> _languageMap = {
    "English": TranslateLanguage.english,
    "French": TranslateLanguage.french,
    "Spanish": TranslateLanguage.spanish,
    "German": TranslateLanguage.german,
    "Hindi": TranslateLanguage.hindi,
    "Chinese": TranslateLanguage.chinese,
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
              // Input Language Container
              _buildTranslationContainer(
                label: "Input",
                dropdownValue: _inputLanguage,
                onChanged: (newValue) {
                  setState(() => _inputLanguage = newValue!);
                },
                controller: _textController,
                isEditable: true,
              ),
        
              SizedBox(height: 20),
        
              // Output Language Container
              _buildTranslationContainer(
                label: "Output",
                dropdownValue: _outputLanguage,
                onChanged: (newValue) {
                  setState(() => _outputLanguage = newValue!);
                },
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

  Widget _buildTranslationContainer({
    required String label,
    required String dropdownValue,
    required void Function(String?) onChanged,
    TextEditingController? controller,
    String? text,
    required bool isEditable,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 200,
      width: 600,
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
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              underline: SizedBox(),
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              items: _languageMap.keys.map((String lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),
              onChanged: onChanged,
            ),
          ),

          SizedBox(height: 10),

          // Input TextField or Translated Text
          isEditable
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(border: InputBorder.none),
                )
              : Text(
                  text ?? "Translation appears here...",
                  style: TextStyle(fontSize: 18),
                ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// class TranslationPage extends StatefulWidget {
//   @override
//   _TranslationPageState createState() => _TranslationPageState();
// }

// class _TranslationPageState extends State<TranslationPage> {
//   final TextEditingController _textController = TextEditingController();
//   String _translatedText = "Translation will appear here...";
//   String _selectedLanguage = "French"; // Default target language

//   // Language Map for Dropdown & ML Kit
//   final Map<String, TranslateLanguage> _languageMap = {
//     "French": TranslateLanguage.french,
//     "Spanish": TranslateLanguage.spanish,
//     "German": TranslateLanguage.german,
//     "Hindi": TranslateLanguage.hindi,
//     "Chinese": TranslateLanguage.chinese,
//   };

//   Future<void> translateText() async {
//     if (_textController.text.isEmpty) return;

//     try {
//       final translator = OnDeviceTranslator(
//         sourceLanguage: TranslateLanguage.english, // Source is always English
//         targetLanguage: _languageMap[_selectedLanguage]!,
//       );

//       final translatedText = await translator.translateText(_textController.text);
//       setState(() {
//         _translatedText = translatedText;
//       });
//     } catch (e) {
//       setState(() {
//         _translatedText = "Error: ${e.toString()}";
//       });
//       print("Translation Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Text Translator")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 labelText: "Enter text",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Language Selection Dropdown
//             DropdownButton<String>(
//               value: _selectedLanguage,
//               items: _languageMap.keys.map((String lang) {
//                 return DropdownMenuItem(value: lang, child: Text(lang));
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedLanguage = newValue!;
//                 });
//               },
//             ),

//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: translateText,
//               child: Text("Translate"),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Translated Text:",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               _translatedText,
//               style: TextStyle(fontSize: 18, color: Colors.blue),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
