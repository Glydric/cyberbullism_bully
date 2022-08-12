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
  Widget _body = const Center(
    child: Text("Eseguire il login"),
  );

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(
      body: _body,
      appBar: AppBar(
        title: const Text("Le tue segnalazioni"),
      ),
    );
  }

  void initUser() async {
    try {
      final User user = await UserSavingManager.getUser();
      _body = user.runtimeType.toString() == "Psyco"
          ? UserSegnalazione(user)
          : const PsycoSegnalazioni();
      setState(() => _body);
    } catch (e) {
      debugPrint("Utente non trovato, ");
    }
  }
}
