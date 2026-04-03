// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/new_home.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBqeK13cRAIj1KFvzXZ5bq4eVr5DFzUsH8",
      appId: "1:505335614510:android:87f59fb866b360980f23bf",
      messagingSenderId: "505335614510",
      projectId: "newsapp-389d5",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
