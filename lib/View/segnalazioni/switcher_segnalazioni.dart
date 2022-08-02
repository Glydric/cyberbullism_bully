import 'package:flutter/material.dart';
import '../../Model/user_save_manager.dart';
import '/Model/user.dart';
import '/View/segnalazioni/psy_segnalazione.dart';
import '/View/segnalazioni/user_segnalazione.dart';

class SegnalazioniPage extends StatelessWidget {
  User? user;

  SegnalazioniPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(
        body: user.runtimeType.toString() == "Psyco"
            ? const PsycoSegnalazione()
            : const UserSegnalazione());
  }

  void initUser() async {
    try {
      user = await UserSavingManager.getUser();
    } catch (e) {}
  }
}
