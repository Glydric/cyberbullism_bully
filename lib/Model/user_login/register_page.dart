import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../psyco/psyco.dart';
import '../psyco/psyco_url_getter.dart';
import 'user_info_page.dart';

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
                  const Text("Registrati", style: TextStyle(fontSize: 20)),
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
                  Row(children: [
                    const Text("Registrazione da psicologo"),
                    Switch(
                      onChanged: (value) => setState(() => _isPsy = value)

                      // if (_isPsy) _emailController.clear();
                      ,
                      value: _isPsy,
                    ),
                  ]),

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
      await PsycoUrlGetter.getFuturePsyco(
              _nomeController.text, _cognomeController.text, "")
          .then(
        (Psyco psy) {
          if (_emailController.text != psy.email) {
            setState(() => _errorName = "Pec psicologo non valida");
          } else if (psy.isValid == "true" &&
              _nomeController.text == psy.nome.toLowerCase() &&
              _cognomeController.text == psy.cognome.toLowerCase()) {
            userSignUp();
            _errorName = "";
          } else {
            setState(() => _errorName = "Psicologo non valido");
          }
        },
      );
    } on RangeError {
      setState(() => _errorName = "Psicologo non iscritto all'albo");
    }
  }

  ///create a new user
  void userSignUp() async {
    try {
      toPage(
        UserInfoPage(
          credential: await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passowordController.text),
        ),
      );
      _errorName = "";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() => _errorName = "La password non è sicura");
      } else if (e.code == "email-already-in-use") {
        setState(
            () => _errorName = "The account already exists for that email.");
      }
      if (e.code == "invalid-email") {
        setState(() => _errorName = "Inserire un'email corretta");
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  void backToLoginPage() => Navigator.pop(context);
}
