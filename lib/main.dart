import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screen_switcher.dart';
import 'package:firebase_core/firebase_core.dart';

/// Questa classe è la classe principale che avvia tutta l'app flutter
void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* initialRoute: '/UserInfo', //'/main',
      routes: {
        //'/main': (context) => HomePage(),
        '/UserInfo': (context) => const UserInfo('', 'api', ''),
      }, */
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
      ),
      home: const ScreenSwitcher(),
    );
  }
}
