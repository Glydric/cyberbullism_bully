import 'package:flutter/material.dart';
import '/Model/user.dart';
import '/Model/user_save_manager.dart';
import 'psyco/home.dart';
import 'user/home.dart';

class SegnalazioniPage extends StatefulWidget {
  const SegnalazioniPage({Key? key}) : super(key: key);

  @override
  State<SegnalazioniPage> createState() => _SegnalazioniPageState();
}

class _SegnalazioniPageState extends State<SegnalazioniPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Le tue segnalazioni")),
        body: FutureBuilder(
          future: UserSavingManager.getUser(),
          builder: (_, AsyncSnapshot<User> snapshot) =>
              snapshot.hasError
                  ? const Center(child: Text("Eseguire il login"))
                  : (snapshot.hasData
                      ? (snapshot.requireData.runtimeType.toString() == "Psyco"
                          ? const PsycoSegnalazioni()
                          : UserSegnalazione(snapshot.requireData))
                      : const CircularProgressIndicator.adaptive()),
        ),
      );
}
