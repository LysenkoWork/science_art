import 'package:flutter/material.dart';
import '/pages/home/home_page.dart';
import '/pages/test_page.dart';

void main() {
  runApp(const ScienceArtSpace());
}

class ScienceArtSpace extends StatelessWidget {
  const ScienceArtSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      //home: TestPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


