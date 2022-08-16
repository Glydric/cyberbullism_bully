import 'package:cyberbullism_bully/Model/user.dart';
import 'package:flutter/material.dart';

import '/Model/connect_db/login_exception.dart';
import '/Model/connect_db/db_connector.dart';
import '/Model/psyco/psyco.dart';
import '/Model/psyco/psyco_url_getter.dart';

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
                  const Spacer(),
                  const Text(
                    "", //TODO inserire il titolo
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
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

  void registrazione() => _isPsy ? psySignUp() : userSignUp();

  ///create a new psicologo
  void psySignUp() async {
    try {
      await psyChecks();

      await DbConnector.addPsy(
        User(
          _nomeController.text,
          _cognomeController.text,
          _emailController.text,
          _passwordController.text,
        ),
      );

      backToLoginPage();
      _errorName = "";
    } on LoginException catch (e) {
      switch (e.toString()) {
        case "weak-password":
          _errorName = "La password non è sicura";
          break;
        case "email-already-in-use":
          _errorName = "L'account è già esistente";
          break;
        case "invalid-email":
          _errorName = "Inserire un'email valida";
          break;
        case "pec-invalid":
          _errorName = "Pec psicologo non valida";
          break;
        case "psy-invalid":
          _errorName = "Psicologo sospeso dalla carica";
          break;
        case "psy-not-found":
          _errorName = "Psicologo non iscritto all'albo";
          break;
        default:
          debugPrint(e.toString());
      }
    } finally {
      setState(() => _errorName);
    }
  }

  psyChecks() async {
    LoginException.psyThrower(
      await PsycoUrlGetter.getFuturePsyco(
        _nomeController.text,
        _cognomeController.text,
        "", //TODO implementare l'ordine
        _passwordController.text,
      ),
      _emailController.text,
      _nomeController.text,
      _cognomeController.text,
    );
  }

  ///create a new user
  void userSignUp() async {
    try {
      await DbConnector.addUser(
        User(
          _nomeController.text,
          _cognomeController.text,
          _emailController.text,
          _passwordController.text,
        ),
      );

      backToLoginPage();
      _errorName = "";
    } on LoginException catch (e) {
      switch (e.toString()) {
        case "weak-password":
          _errorName = "La password non è sicura";
          break;
        case "email-already-in-use":
          _errorName = "L'account è già esistente";
          break;
        case "invalid-email":
          _errorName = "Inserire un'email valida";
          break;
        default:
          debugPrint(e.toString());
      }
    } finally {
      setState(() => _errorName);
    }
  }

  void backToLoginPage() => Navigator.pop(context);
}
