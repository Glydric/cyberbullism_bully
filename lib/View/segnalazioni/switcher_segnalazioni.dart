import 'package:flutter/material.dart';
import '../../Model/user_save_manager.dart';
import '/Model/user.dart';
import '/View/segnalazioni/psy_segnalazione.dart';
import 'user/home.dart';

class SegnalazioniPage extends StatefulWidget {
  const SegnalazioniPage({Key? key}) : super(key: key);

  @override
  State<SegnalazioniPage> createState() => _SegnalazioniPageState();
}

class _SegnalazioniPageState extends State<SegnalazioniPage> {
  User? user;

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(
        body: user.runtimeType.toString() == "Psyco"
            ? const PsycoSegnalazione()
            : const HomeSegnalazioni());
  }

  void initUser() async {
    try {
      user = await UserSavingManager.getUser();
      setState(() => user);
    } catch (e) {}
  }
}
