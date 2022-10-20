import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/user_save_manager.dart';
import 'package:cyberbullism_bully/View/segnalazioni/psyco/home.dart';
import 'package:cyberbullism_bully/View/segnalazioni/user/home.dart';

class SegnalazioniPage extends StatefulWidget {
  const SegnalazioniPage({Key? key}) : super(key: key);

  @override
  State<SegnalazioniPage> createState() => _SegnalazioniPageState();
}

class _SegnalazioniPageState extends State<SegnalazioniPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Chat")),
        body: FutureBuilder(
          future: UserSavingManager.getUser(),
          builder: (_, AsyncSnapshot<User> snapshot) => snapshot.hasError
              ? const Center(child: Text("Eseguire il login"))
              : (snapshot.hasData
                  ? (snapshot.requireData.runtimeType.toString() == "Psyco"
                      ? PsycoSegnalazioni(snapshot.requireData)
                      : UserSegnalazione(snapshot.requireData))
                  : const CircularProgressIndicator.adaptive()),
        ),
      );
}
