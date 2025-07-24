// main.dart
import 'package:flutter/material.dart';
import 'package:safeguard/screens/location_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GetLocation(),
    );
  }
}
