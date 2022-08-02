import 'package:flutter/material.dart';

import '/Model/user_save_manager.dart';
import 'login_registration/login_page.dart';
import 'user_info_page.dart';

class LoginPageSwitcher extends StatefulWidget {
  const LoginPageSwitcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageSwitcherState();
}

class LoginPageSwitcherState extends State<LoginPageSwitcher> {
  final _screens = const [
    Scaffold(),
    // PsycoInfoPage(),
    UserInfoPage(),
    UserInfoPage(),
    LogInPage(),
  ];

  int _index = 0;

  void initUser() async {
    try {
      final user = await UserSavingManager.getUser();
      switch (user.runtimeType.toString()) {
        case "Psyco":
          setState(() => _index = 1);
          break;
        case "User":
          setState(() => _index = 2);
          break;
        default:
          setState(() => _index = 3);
      }
    } catch (e) {
      debugPrint("Utente non trovato, login");
    }
  }

  @override
  initState() {
    initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _screens[_index]);
}
