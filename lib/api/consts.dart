import 'package:flutter_dotenv/flutter_dotenv.dart';

String GEMINI_API_KEY = "${dotenv.env["APIKEY"]}";
//https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}