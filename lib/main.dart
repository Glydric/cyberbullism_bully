import 'package:flutter/material.dart';
import 'main_switcher.dart';

void main() async => runApp(const MainApp());

/// Questa classe è la classe principale che avvia tutta l'app flutter
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          // useMaterial3: true,
          textTheme: Theme.of(context).textTheme.copyWith(
                labelSmall: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(letterSpacing: 0),
              ),
          textButtonTheme: textButtonTheme,
        ),
        home: const ScreenSwitcher(),
      );
}