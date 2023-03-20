import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const baseUrl = 'https://615f5fb4f7254d0017068109.mockapi.io/api/v1';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kawa App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginScreen(),
    );
  }
}
