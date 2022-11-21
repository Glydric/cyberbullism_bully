import 'package:cyberbullism_bully/Model/user.dart';
import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/connect_db/psyco_db_connector.dart';
import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';
import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorName = "";
  bool _isPsy = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Registrati",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  TextFormField(
                    decoration:
                        InputDecoration(label: Text(_isPsy ? "Pec" : "Email")),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Nome")),
                    controller: _nomeController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Cognome")),
                    controller: _cognomeController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Password")),
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                  ), // PasswordField

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
                  SwitchListTile.adaptive(
                    //il metodo adaptive fa cambiare lo switch in base alla piattaforma
                    title: const Text("Registrazione da psicologo"),
                    onChanged: (value) => setState(() => _isPsy = value),
                    value: _isPsy,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: registrazione,
                    child: const Text("Register"),
                  ),
                  TextButton(
                    onPressed: backToLoginPage,
                    child: const Text("Già iscritto? Accedi"),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      );

  ///create a new psicologo
  void registrazione() async {
    try {
      final user = User(
        _nomeController.text,
        _cognomeController.text,
        _emailController.text,
        _passwordController.text,
      );

      _isPsy
          ? await PsycoDbConnector.addUser(user)
          : await UserDbConnector.addUser(user);

      backToLoginPage();
      _errorName = "";
    } on LoginException catch (e) {
      _errorName = e.toString();
    } on Exception catch (e) {
      _errorName = "Errore generico";
      if (e.runtimeType.toString() == "_ClientSocketException") {
        _errorName = "Errore di rete";
      }
    } 
    finally {
      setState(() => _errorName);
    }
  }

  void backToLoginPage() => Navigator.of(context).pop(true);
}
