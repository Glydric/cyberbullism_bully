import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:flutter/material.dart';

// importo pagine flutter
import 'package:cyberbullism_bully/View/segnalazioni/switcher.dart';
import 'package:cyberbullism_bully/View/profile/home_page.dart';
import 'package:cyberbullism_bully/View/learning/learning.dart';

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({Key? key}) : super(key: key);

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {
  int _index = 0;

  final Map<Widget, NavigationDestination> map = {
    const LearningPage(): const NavigationDestination(
      label: "Learning",
      icon: Icon(Icons.description),
    ),
    const SegnalazioniPage(): const NavigationDestination(
      label: "Chat",
      icon: Icon(Icons.chat),
    ),
    const HomePage(): const NavigationDestination(
      label: "User",
      icon: Icon(Icons.account_circle),
    )
  };

  List<Widget> get getPages => map.keys.toList();

  List<NavigationDestination> get getItems => map.values.toList();

  _updateIndex(int value) => setState(() => _index = value);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: UserSavingManager.getUser(),
        builder: (_, AsyncSnapshot snapshot) => Scaffold(
          body: getPages[_index],
          bottomNavigationBar: NavigationBar(
            
            onDestinationSelected: _updateIndex,
            selectedIndex: _index,
            destinations: getItems,
          ),
        ),
      );
}
