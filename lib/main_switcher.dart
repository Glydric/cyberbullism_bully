import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:cyberbullism_bully/View/segnalazioni/psyco/lista_segnalazione.dart';

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
  late Timer timer;
  late Map<Widget, NavigationDestination> navigatorMap;

  List<Widget> get getPages => navigatorMap.keys.toList();

  List<NavigationDestination> get getItems => navigatorMap.values.toList();

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => updateNav(),
    );
    super.initState();
  }

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

  _updateIndex(int value) => setState(() => _index = value);

  updateNav() async {
    try {
      final user = await UserSavingManager.getUser();
      navigatorMap = user.runtimeType.toString() == "Psyco"
          ? {
              const HomePage(): const NavigationDestination(
                label: "User",
                icon: Icon(Icons.account_circle),
              ),
              const SegnalazioniPage(): const NavigationDestination(
                label: "Chat",
                icon: Icon(Icons.chat),
              ),
              ListaSegnalazioni(user): const NavigationDestination(
                label: "Segnalazioni",
                icon: Icon(Icons.list),
              ),
              const LearningPage(): const NavigationDestination(
                label: "Learning",
                icon: Icon(Icons.description),
              ),
            }
          : {
              const HomePage(): const NavigationDestination(
                label: "User",
                icon: Icon(Icons.account_circle),
              ),
              const SegnalazioniPage(): const NavigationDestination(
                label: "Chat",
                icon: Icon(Icons.chat),
              ),
              const LearningPage(): const NavigationDestination(
                label: "Learning",
                icon: Icon(Icons.description),
              ),
            };
    } catch (e) {
      navigatorMap = {
        const HomePage(): const NavigationDestination(
          label: "User",
          icon: Icon(Icons.account_circle),
        ),
        const LearningPage(): const NavigationDestination(
          label: "Learning",
          icon: Icon(Icons.description),
        ),
      };
    } finally {
      setState(() => navigatorMap);
    }
  }
}
