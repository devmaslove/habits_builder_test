import 'package:flutter/material.dart';
import 'package:habits_builder_test/screens/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Manrope',
        primarySwatch: Colors.blue,
      ),
      home: const IntroductionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
