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
    user = await UserSavingManager.getUser();
    setState(() => user);
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
          ],
        ),
      ),
    );
  }
}
