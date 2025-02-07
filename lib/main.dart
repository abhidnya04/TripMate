import 'package:appdev/pages/documents.dart';
import 'package:appdev/pages/login.dart';
import 'package:appdev/pages/tabs.dart';
import 'package:appdev/pages/upload_docs.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
        url: 'https://dzsweolrpmfwdjqvtnni.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6c3dlb2xycG1md2RqcXZ0bm5pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4MjkwODksImV4cCI6MjA1NDQwNTA4OX0.FmLD4bx5KCCEDIxBFBbqxOBiUT3KwOHcIT2iOwhvGgU');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TabsScreen(),
        routes: {
        '/login': (context) =>   LoginPage(),
        '/signup': (context) =>  LoginPage(),
        '/uploadDocs': (context) =>  UploadPage(),
        '/myDocs': (context) =>  MyDocuments(),

      },
    );
  }
}

