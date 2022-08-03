import 'package:flutter/material.dart';

import '/Model/user_save_manager.dart';
import "/Model/user.dart";

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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
            const ElevatedButton(
              onPressed: UserSavingManager.removeUser,
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
