import 'package:flutter/material.dart';

import '../utils/languages.dart';

class TranslationContainer extends StatelessWidget {
  final String dropdownValue;
  final void Function(String?) onChanged;
  final TextEditingController? controller;
  final String? text;
  final bool isEditable;
  final String? hintText;

  const TranslationContainer({
    super.key,
    required this.dropdownValue,
    required this.onChanged,
    this.controller,
    this.text,
    required this.isEditable,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 600,
      padding: const EdgeInsets.all(12),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.lightGreen[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              dropdownColor: Colors.lightGreen[300],
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: languageMap.keys.map((String lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Row(
                    children: [
                      Text(languageFlags[lang] ?? ""), // Display flag
                      const SizedBox(width: 10), // Spacing
                      Text(lang),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),

          const SizedBox(height: 10),

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
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
        ],
      ),
    );
  }
}
