import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final UserCredential credential;

  const UserInfoPage({Key? key, required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Text("UserName:"),
              Text(credential.user.toString()),
            ],
          ),
        ),
      );
}
