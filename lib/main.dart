import 'package:flutter/material.dart';
import 'main_switcher.dart';

/// Questa classe è la classe principale che avvia tutta l'app flutter
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
        ),
      ),
      home: const ScreenSwitcher(),
    );
  }
}
