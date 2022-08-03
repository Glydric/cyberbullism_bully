import 'package:flutter/material.dart';

import '/Model/user_save_manager.dart';
import 'login_registration/login_page.dart';
import 'user_info_page.dart';

class LoginPageSwitcher extends StatefulWidget {
  const LoginPageSwitcher({Key? key}) : super(key: key);

  @override
  State<LoginPageSwitcher> createState() => _LoginPageSwitcherState();
}

class _LoginPageSwitcherState extends State<LoginPageSwitcher> {
  final _screens = const [
    // PsycoInfoPage(),
    LogInPage(),
    UserInfoPage(),
    UserInfoPage(),
  ];

  int _index = 0;

  void initUser() async {
    try {
      final user = await UserSavingManager.getUser();
      switch (user.runtimeType.toString()) {
        case "Psyco":
          _index = 1;
          break;
        case "User":
          _index = 2;
          break;
        default:
          _index = 0;
      }
    } catch (e) {
      debugPrint("Utente non trovato, login");
    }
  }

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(body: _screens[_index]);
  }
}
