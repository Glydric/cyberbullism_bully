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
  User? user;

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
      body: SafeArea(
        child: Column(
          children: [
            const Text("UserName:"),
            Text(user.toString()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
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
            )
          ],
        ),
      ),
    );
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
}
