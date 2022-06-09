import 'package:flutter/material.dart';
import 'screen_switcher.dart';

/// Questa classe è la classe principale che avvia tutta l'app flutter
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: '/UserInfo', //'/main', 
      // routes: {
      //   //'/main': (context) => HomePage(),
      //   '/UserInfo': (context) => const UserInfo('', 'api', ''),
      // },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenSwitcher(),
    );
  }
}
