import 'package:apitesting/homescreen.dart';
import 'package:flutter/material.dart';

//a clear, simple, and null-safe example of how to fetch JSON data from an API and display it in a ListView using FutureBuilder in Flutter.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Homescreen();
  }
}
