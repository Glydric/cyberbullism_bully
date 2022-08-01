import 'package:flutter/material.dart';

import "/Model/user.dart";

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage(this.user, {Key? key}) : super(key: key);

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
