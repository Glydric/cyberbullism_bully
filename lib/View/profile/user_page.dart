import 'package:flutter/material.dart';

import '/Model/user_save_manager.dart';
import "/Model/user.dart";
import 'login_registration/change_password.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? user;//TODO move user getter to superior page

  void initUser() async {
    try {
      user = await UserSavingManager.getUser();
      setState(() => user);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(
      appBar: AppBar(title: const Text("Utente")),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(),
              Text(
                user!.nome + " " + user!.cognome,
                style: const TextStyle(fontSize: 20),
              ),
              Text(user!.email),
              const Spacer(
                flex: 3,
              ),
              Row(children: [
                const ElevatedButton(
                  onPressed: UserSavingManager.removeUser,
                  child: Text("Logout"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => toPage(ChangePassword(user!)),
                  child: const Text("Change Password"),
                ),
              ]),
            ],
          )),
    );
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
}
