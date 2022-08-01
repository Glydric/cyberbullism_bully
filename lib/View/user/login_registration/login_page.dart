import 'package:flutter/material.dart';

import '../../../Model/connect_db/user_connector.dart';
import '/Model/user.dart';
import '/Model/psyco/psyco.dart';
import '/Model/user_saving_manager.dart';

import '/View/user/user_info_page.dart';

import 'register_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();
  String _errorName = "";

  // @override
  // initState() async {
  //   try {
  //     User user = await UserSavingManager.getUser();
  //     if (user.runtimeType == User) {
  //       toPage(UserInfoPage(user));
  //     } else if (user.runtimeType == Psyco) {
  //       toPage(UserInfoPage(user));
  //     }
  //   } catch (e) {
  //     debugPrint("Utente non trovato, login");
  //   }
  //   super.initState();
  // }

  ///Sign In user
  void signIn() async {
    try {
      User user = await DbUserConnector.getUser(
          _emailController.text,
          _passowordController.text);

      toPage(
        UserInfoPage(user),
      );
      _errorName = "";
    } on Exception catch (e) {
      if (e.toString() == "invalid-email") {
        setState(() => _errorName = "Inserire un'email corretta");
      }
      if (e.toString() == "user-not-found") {
        setState(() => _errorName = "Utente non registrato");
      }
      if (e.toString() == "wrong-password") {
        setState(() => _errorName = "Password Errata");
      }
      if (e.toString() == "too-many-requests") {
        setState(() => _errorName = "Troppi tentativi, provare più tardi");
      }
      debugPrint(e.toString());
    }
  }

  toRegisterPage() => toPage(const RegisterPage());

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "", //todo inserire il titolo
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const Spacer(),
                  const Text("Bentornato", style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  const Spacer(),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                  ),

                  TextFormField(
                    controller: _passowordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(label: Text("Password")),
                  ), // PasswordField

                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _errorName,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  const Spacer(),

                  const Spacer(),
                  ElevatedButton(
                    onPressed: signIn,
                    child: const Text("Login"),
                  ),
                  TextButton(
                    onPressed: toRegisterPage,
                    child: const Text("Non sei iscritto? Registrati"),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}
