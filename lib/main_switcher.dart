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

  final Map<Widget, NavigationDestination> navigatorMap = {
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

  List<Widget> get getPages => navigatorMap.keys.toList();

  List<NavigationDestination> get getItems => navigatorMap.values.toList();

  @override
  void initState() {
    checkPsy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: UserSavingManager.getUser(),
        builder: (_, AsyncSnapshot snapshot) => Scaffold(
          body: getPages[_index],
          bottomNavigationBar: NavigationBar(
            // TODO inserire un'altra tab solo se psicologo
            onDestinationSelected: _updateIndex,
            selectedIndex: _index,
            destinations: getItems,
          ),
        ),
      );
  _updateIndex(int value) => setState(() => _index = value);

  void checkPsy() async {
    
  }

}
