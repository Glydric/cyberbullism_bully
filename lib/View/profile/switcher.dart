import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/user_save_manager.dart';
import 'login_registration/login_page.dart';
import 'login_registration/change_password.dart';

class LoginPageSwitcher extends StatefulWidget {
  const LoginPageSwitcher({Key? key}) : super(key: key);

  @override
  State<LoginPageSwitcher> createState() => _LoginPageSwitcherState();
}

class _LoginPageSwitcherState extends State<LoginPageSwitcher> {
  logoutAlertDialog() async {
    var result = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Eseguire il logout?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No"),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Si"),
                ),
              ],
            ));
    if (result == true) {
      UserSavingManager.removeUser();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Utente")),
        body: FutureBuilder(
          future: UserSavingManager.getUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) =>
              snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        const Spacer(),
                        if (snapshot.requireData.runtimeType.toString() ==
                            "Psyco")
                          const Text("Psycologo"),
                        Text(
                          snapshot.requireData.nome +
                              " " +
                              snapshot.requireData.cognome,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(snapshot.requireData.email),
                        const Spacer(
                          flex: 3,
                        ),
                        Row(children: [
                          ElevatedButton(
                            onPressed: logoutAlertDialog,
                            child: const Text("Logout"),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () => showMyBottomSheet(
                                ChangePassword(snapshot.requireData)),
                            child: const Text("Cambia Password"),
                          ),
                        ])
                      ]),
                    )
                  : Center(
                      child: ElevatedButton(
                        onPressed: () => showMyBottomSheet(const LogInPage()),
                        child: const Text("LogIn"),
                      ),
                    ),
        ),
      );

  void showMyBottomSheet(Widget page) => showModalBottomSheet(
          context: context,
          builder: (_) => page,
          backgroundColor:
              const Color.fromARGB(0, 0, 0, 0) // this is transparent
          )
      .whenComplete(() => setState(() {}));
}
