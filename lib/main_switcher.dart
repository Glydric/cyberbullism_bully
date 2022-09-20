import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:cyberbullism_bully/View/segnalazioni/psyco/lista_segnalazione.dart';
import 'package:flutter/material.dart';

// importo pagine flutter
import 'package:cyberbullism_bully/View/segnalazioni/switcher.dart';
import 'package:cyberbullism_bully/View/profile/home_page.dart';
import 'package:cyberbullism_bully/View/learning/learning.dart';
import 'package:http/http.dart';

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({Key? key}) : super(key: key);

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {
  int _index = 0;

  late Map<Widget, NavigationDestination> navigatorMap;

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
  _updateIndex(int value) {
    checkPsy();
    setState(() => _index = value);
  }

  checkPsy() async {
    try {
      final user = await UserSavingManager.getUser();
      if (user.runtimeType.toString() == "Psyco") {
        navigatorMap = {
          const LearningPage(): const NavigationDestination(
            label: "Learning",
            icon: Icon(Icons.description),
          ),
          const SegnalazioniPage(): const NavigationDestination(
            label: "Chat",
            icon: Icon(Icons.chat),
          ),
          ListaSegnalazioni(user): const NavigationDestination(
              label: "Segnalazioni", icon: Icon(Icons.list)),
          const HomePage(): const NavigationDestination(
            label: "User",
            icon: Icon(Icons.account_circle),
          ),
        };
      } else {
        throw Exception();
      }
    } catch (e) {
      navigatorMap = {
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
    }
  }
}
