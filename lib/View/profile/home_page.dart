import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/user_save_manager.dart';
import 'login_registration/login_page.dart';
import 'login_registration/change_password.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: UserSavingManager.getUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) =>
            snapshot.hasError
                ? Scaffold(
                    appBar: AppBar(title: const Text("Profilo")),
                    body: Center(
                      child: ElevatedButton(
                        onPressed: () => showMyBottomSheet(const LogInPage()),
                        child: const Text("LogIn"),
                      ),
                    ),
                  )
                : snapshot.hasData
                    ? getInfoScreen(snapshot.requireData)
                    : Scaffold(
                        appBar: AppBar(),
                        body: const CircularProgressIndicator.adaptive(),
                      ),
      );

  Text getTitle(User user) => user.runtimeType.toString() == "Psyco"
      ? const Text("Psicologo")
      : const Text("Utente");

  Widget getInfoScreen(User user) => Scaffold(
        appBar: AppBar(title: getTitle(user)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32).copyWith(top: 64),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    user.nome + " " + user.cognome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    user.email,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => showMyBottomSheet(ChangePassword(user)),
                    child: const Text("Cambia Password"),
                  ),
                  ElevatedButton(
                    onPressed: logoutAlertDialog,
                    child: const Text("Logout"),
                  ),
                ]),
          ),
        ),
      );

  void logoutAlertDialog() async {
    final result = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Eseguire il logout?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No"),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Si"),
                ),
              ],
            ));
    if (result == true) {
      UserSavingManager.removeUser();
      setState(() {});
    }
  }

  void showMyBottomSheet(Widget page) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => page,
        // trasparente
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ).whenComplete(() => setState(() {}));
}
