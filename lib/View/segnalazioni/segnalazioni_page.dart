import 'package:flutter/material.dart';
import '/Model/user.dart';
import '/View/segnalazioni/psy_segnalazione.dart';
import '/View/segnalazioni/user_segnalazione.dart';

class SegnalazioniPage extends StatelessWidget {
  final User user;

  const SegnalazioniPage(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: user.runtimeType.toString() == "Psyco"
            ? const PsycoSegnalazione()
            : const UserSegnalazione());
  }
}
