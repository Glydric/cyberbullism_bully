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
  Widget _screen = Container();

  void initUser() async {
    try {
      final user = await UserSavingManager.getUser();
      switch (user.runtimeType.toString()) {
        case "Psyco":
        // _screen = const UserInfoPage();
        // // PsycoInfoPage(),
        // break;
        case "User":
          _screen = const UserInfoPage();
      }
      setState(() => _screen);
    } catch (e) {
      debugPrint("Utente non trovato, login");
      toPage(const LogInPage());
    }
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ).whenComplete(() => setState(() => _screen));

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(body: _screen);
  }
}
