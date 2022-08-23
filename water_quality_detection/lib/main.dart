import 'package:flutter/material.dart';
import 'package:water_quality_detection/Auth/loginPage.dart';

import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Detection',
      theme: ThemeData(
          // primarySwatch: Colors.deepPurpleAccent,
          ),
      home: const LoginPage(),
    );
  }
}
