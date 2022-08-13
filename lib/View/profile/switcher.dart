import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/user_save_manager.dart';
import 'login_registration/login_page.dart';
import 'user_page.dart';

class LoginPageSwitcher extends StatefulWidget {
  const LoginPageSwitcher({Key? key}) : super(key: key);

  @override
  State<LoginPageSwitcher> createState() => _LoginPageSwitcherState();
}

class _LoginPageSwitcherState extends State<LoginPageSwitcher> {
  toPage(Widget page) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page))
      .whenComplete(() => setState(() {}));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Utente")),
        body: FutureBuilder(
          future: UserSavingManager.getUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) =>
              snapshot.hasData
                  ? UserPage(snapshot.requireData)
                  : Scaffold(
                      body: Center(
                        child: ElevatedButton(
                          onPressed: () => toPage(const LogInPage()),
                          child: const Text("LogIn"),
                        ),
                      ),
                    ),
        ),
      );
}
