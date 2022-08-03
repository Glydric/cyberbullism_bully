import 'package:flutter/material.dart';

import '/Model/connect_db/user_connector.dart';
import '/Model/connect_db/login_exception.dart';
import '/Model/user.dart';
import '/Model/user_save_manager.dart';

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

  ///Sign In user
  void signIn() async {
    try {
      User user = await DbUserConnector.getUser(
        _emailController.text,
        _passowordController.text,
      );

      UserSavingManager.saveUser(user);

      Navigator.pop(context);

      _errorName = "";
    } on LoginException catch (e) {
      switch (e.toString()) {
        case "invalid-email":
          _errorName = "Inserire un'email corretta";
          break;
        case "user-not-found":
          _errorName = "Utente o password errata";
          break;
        case "too-many-requests":
          _errorName = "Troppi tentativi, provare più tardi";
          break;
        default:
          debugPrint(e.toString());
      }
    } finally {
      setState(() => _errorName);
    }
  }

  toRegisterPage() => toPage(const RegisterPage());

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Bentornato", style: TextStyle(fontSize: 20)),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Spacer(),
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
