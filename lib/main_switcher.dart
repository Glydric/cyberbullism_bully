import 'package:cyberbullism_bully/Model/maps_utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:cyberbullism_bully/Model/user.dart';

// importo pagine flutter
import 'package:cyberbullism_bully/View/segnalazioni/switcher.dart';
import 'package:cyberbullism_bully/View/profile/home_page.dart';
import 'package:cyberbullism_bully/View/learning/learning.dart';
import 'package:cyberbullism_bully/View/segnalazioni/psyco/lista_segnalazioni.dart';

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({Key? key}) : super(key: key);

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {
  int _index = 0;
  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) => setState(() {}),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: UserSavingManager.getUser(),
        builder: (_, AsyncSnapshot<User> snapshot) => buildScaffold(
          !snapshot.hasError && snapshot.hasData
              ? getNavBasedOn(snapshot.requireData)
              : {
                  const HomePage(): const NavigationDestination(
                    label: "User",
                    icon: Icon(Icons.account_circle),
                  ),
                },
        ),
      );

  _updateIndex(int value) => setState(() => _index = value);

  Scaffold buildScaffold(Map<Widget, NavigationDestination> map) {
    MapsUtils.concatenateMaps(map, {
      const LearningPage(): const NavigationDestination(
        label: "Learning",
        icon: Icon(Icons.description),
      )
    });
    return Scaffold(
      body: map.keys.elementAt(_index),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _updateIndex,
        selectedIndex: _index,
        destinations: map.values.toList(),
      ),
    );
  }

  Map<Widget, NavigationDestination> getNavBasedOn(User user) =>
      MapsUtils.concatenateMapsIf(
        user.runtimeType.toString() == "Psyco",
        {
          const HomePage(): const NavigationDestination(
            label: "User",
            icon: Icon(Icons.account_circle),
          ),
          const SegnalazioniPage(): const NavigationDestination(
            label: "Chat",
            icon: Icon(Icons.chat),
          ),
        },
        {
          ListaSegnalazioni(user): const NavigationDestination(
            label: "Segnalazioni",
            icon: Icon(Icons.list),
          ),
        },
      );
}
