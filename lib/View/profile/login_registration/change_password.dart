import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';
import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';
import 'package:cyberbullism_bully/Model/user.dart';

class ChangePassword extends StatefulWidget {
  final User user;

  const ChangePassword(this.user, {Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String _errorName = "";

  void changePassword() async {
    try {
      await UserDbConnector.modifyPassword(
        widget.user,
        _passwordController.text,
        _newPasswordController.text,
      );

      UserSavingManager.removeUser();
      UserSavingManager.saveUser(User(
        widget.user.nome,
        widget.user.cognome,
        widget.user.email,
        _newPasswordController.text,
      ));
      Navigator.pop(context);
    } on LoginException catch (e) {
      _errorName =
          e.message == "user-not-found" ? "Password errata" : e.toString();
    } finally {
      setState(() => _errorName);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const Spacer(),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Vecchia Password"),
              ),
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Nuova Password"),
              ),
              controller: _newPasswordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
            ),
            Text(
              _errorName,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: changePassword,
              child: const Text("Cambia"),
            ),
            const Spacer(flex: 2)
          ]),
        ),
      );
}
