import 'package:flutter/material.dart';

import '/Model/user.dart';

class ChangePassword extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  
  final User user;

  ChangePassword(this.user, {Key? key}) : super(key: key);

  void changePassword() {}//TODO implementa il cambio password

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Change Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                label: Text("Vecchia Password"),
              ),
            ),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                label: Text("Nuova Password"),
              ),
            ),
            ElevatedButton(
              onPressed: changePassword,
              child: const Text("Cambia"),
            )
          ]),
        ),
      );
}
