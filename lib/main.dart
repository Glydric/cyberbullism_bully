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
        bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          elevation: 0,
          showUnselectedLabels: false,
          selectedLabelStyle: const TextStyle(fontSize: 16),
          selectedIconTheme: const IconThemeData(size: 32),
          unselectedIconTheme: const IconThemeData(size: 30),
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              labelSmall: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(letterSpacing: 0),
            ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
        ),
      ),
      home: const ScreenSwitcher(),
    );
  }
}
