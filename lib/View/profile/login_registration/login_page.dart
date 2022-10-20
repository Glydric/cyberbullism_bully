import 'package:flutter/material.dart';

import '/Model/psyco/psyco.dart';
import '/Model/connect_db/psyco_db_connector.dart';
import '/Model/connect_db/user_db_connector.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  String _errorName = "";
  bool _isLoading = false;

  ///Sign In Psyco
  void psycoSignIn() async {
    try {
      setState(() => _isLoading = true);
      Psyco user = await PsycoDbConnector.getUser(
        _emailController.text,
        _passwordController.text,
      );

      UserSavingManager.saveUser(user);
      Navigator.pop(context);

      _errorName = "";
    } on LoginException catch (e) {
      _errorName = e.toString();
    } on Exception catch (e) {
      _errorName = "Errore generico";
      if (e.runtimeType.toString() == "_ClientSocketException") {
        _errorName = "Errore di rete";
      }
    } finally {
      setState(() => _isLoading = false);
      setState(() => _errorName);
    }
  }

  ///Sign In user
  void userSignIn() async {
    try {
      setState(() => _isLoading = true);
      User user = await UserDbConnector.getUser(
        _emailController.text,
        _passwordController.text,
      );

      UserSavingManager.saveUser(user);
      Navigator.pop(context);

      _errorName = "";
    } on LoginException catch (e) {
      if (e.message == "user-not-found") {
        psycoSignIn();
      } else {
        _errorName = e.toString();
      }
    } on Exception catch (e) {
      _errorName = "Errore generico";
      if (e.runtimeType.toString() == "_ClientSocketException") {
        _errorName = "Errore di rete";
      }
    } finally {
      setState(() => _isLoading = false);
      setState(() => _errorName);
    }
  }

  toRegisterPage() => toPage(const RegisterPage());

  toPage(Widget page) => Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (context) => page,
      ))
      .then((v) => {
            if (v == true)
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  content: Text(
                      "Registrazione eseguita con successo, eseguire il login"),
                ),
              ),
          });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _isLoading,
                  child: const CircularProgressIndicator.adaptive(),
                ),
                TextField(
                  decoration: const InputDecoration(label: Text("Email")),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
                TextField(
                  decoration: const InputDecoration(label: Text("Password")),
                  controller: _passwordController,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
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
                ElevatedButton(
                  onPressed: userSignIn,
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: toRegisterPage,
                  child: const Text("Non sei iscritto? Registrati"),
                ),
              ],
            ),
          ),
        ),
      );
}
