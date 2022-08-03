import 'package:cyberbullism_bully/Model/user.dart';
import 'package:flutter/material.dart';

import '/Model/connect_db/user_connector.dart';
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
  final TextEditingController _passowordController = TextEditingController();

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
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: Text(_isPsy ? "Pec" : "Email"),
                    ),
                  ),
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                    ),
                  ),
                  TextFormField(
                    controller: _cognomeController,
                    decoration: const InputDecoration(
                      label: Text("Cognome"),
                    ),
                  ),

                  TextFormField(
                    controller: _passowordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(label: Text("Password")),
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
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );

  void registrazione() => _isPsy ? psySignUp() : userSignUp();

  psySignUp() async {
    try {
      Psyco psy = await PsycoUrlGetter.getFuturePsyco(
        _nomeController.text,
        _cognomeController.text,
        "",
        _passowordController.text,
      );
      if (_emailController.text != psy.email) {
        setState(() => _errorName = "Pec psicologo non valida");
      }
      if (psy.isValid == "true" &&
          _nomeController.text == psy.nome.toLowerCase() &&
          _cognomeController.text == psy.cognome.toLowerCase()) {
        userSignUp(); //TODO migliora la leggibilità
        _errorName = "";
      } else {
        setState(() => _errorName = "Psicologo sospeso dalla carica");
      }
    } on RangeError {
      setState(() => _errorName = "Psicologo non iscritto all'albo");
    }
  }

  ///create a new user
  void userSignUp() async {
    try {
      await DbUserConnector.addUser(
        User(
          _nomeController.text,
          _cognomeController.text,
          _emailController.text,
          _passowordController.text,
        ),
      );
      // toPage(const UserInfoPage());
      backToLoginPage();
      _errorName = "";
    } on Exception catch (e) {
      switch (e.toString()) {
        case "weak-password":
          setState(() => _errorName = "La password non è sicura");
          break;
        case "email-already-in-use":
          setState(() => _errorName = "L'account è già esistente");
          break;
        case "invalid-email":
          setState(() => _errorName = "Inserire un'email valida");
          break;
        default:
          debugPrint(e.toString());
      }
    }
  }

  void backToLoginPage() => Navigator.pop(context);
}
