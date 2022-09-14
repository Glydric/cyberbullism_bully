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
  final Map<Widget, BottomNavigationBarItem> map = {
    const LearningPage(): const BottomNavigationBarItem(
      label: "Learning (in work)",
      icon: Icon(Icons.description),
    ),
    const SegnalazioniPage(): const BottomNavigationBarItem(
      label: "Chat (in work)",
      icon: Icon(Icons.chat),
    ),
    const HomePage(): const BottomNavigationBarItem(
      label: "User",
      icon: Icon(Icons.account_circle_outlined),
    )
  };

  List<Widget> get getPages => map.keys.toList();

  List<BottomNavigationBarItem> get getItems => map.values.toList();

  _updateIndex(int value) => setState(() => _index = value);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: UserSavingManager.getUser(),
        builder: (_, AsyncSnapshot snapshot) => Scaffold(
          body: getPages[_index],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            currentIndex: _index,
            onTap: _updateIndex,
            items: getItems,
          ),
        ),
      );

}
