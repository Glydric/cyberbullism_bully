import 'package:flutter/material.dart';
import '../../Model/user_save_manager.dart';
import '/Model/user.dart';
import '/View/segnalazioni/psy_segnalazione.dart';
<<<<<<< Updated upstream:lib/View/segnalazioni/switcher_segnalazioni.dart
import '/View/segnalazioni/user/lista_segnalazione.dart';
=======
import 'user/lista_segnalazione.dart';
>>>>>>> Stashed changes:lib/View/segnalazioni/segnalazioni_page.dart

class SegnalazioniPage extends StatelessWidget {
  User? user;

  SegnalazioniPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initUser();
    return Scaffold(
        body: user.runtimeType.toString() == "Psyco"
<<<<<<< Updated upstream:lib/View/segnalazioni/switcher_segnalazioni.dart
            ? const PsycoSegnalazione()
            : const ListaSegnalazione());
  }

  void initUser() async {
    try {
      user = await UserSavingManager.getUser();
    } catch (e) {}
=======
            ? PsycoSegnalazione()
            : UserSegnalazione());
>>>>>>> Stashed changes:lib/View/segnalazioni/segnalazioni_page.dart
  }
}
