import 'package:filmfolio/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FilmFolio());
}

class FilmFolio extends StatelessWidget {
  const FilmFolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmFolio',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
