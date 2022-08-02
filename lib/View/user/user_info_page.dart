import 'package:flutter/material.dart';

import '../../Model/user_save_manager.dart';
import "/Model/user.dart";

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  User? user;

  @override
  void initState() {
    initUser();
    super.initState();
  }

  void initUser() async {
    user = await UserSavingManager.getUser();
    setState(() => user);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
