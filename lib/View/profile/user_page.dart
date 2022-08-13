import 'package:flutter/material.dart';

import '/Model/user_save_manager.dart';
import "/Model/user.dart";
import 'login_registration/change_password.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage(this.user, {Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              widget.user.nome + " " + widget.user.cognome,
              style: const TextStyle(fontSize: 20),
            ),
            Text(widget.user.email),
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
                onPressed: () => toPage(ChangePassword(widget.user)),
                child: const Text("Change Password"),
              ),
            ]),
          ],
        ),
      );

  toPage(Widget page) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page),
      );
}
