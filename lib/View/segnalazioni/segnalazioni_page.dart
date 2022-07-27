import 'package:flutter/material.dart';
import '/Model/user.dart';
import '/View/segnalazioni/psy_segnalazione.dart';
import '/View/segnalazioni/user_segnalazione.dart';

class SegnalazionePage extends StatelessWidget {
  final User user;

  const SegnalazionePage(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: user.runtimeType.toString() == "Psyco"
            ? PsycoSegnalazione()
            : UserSegnalazione());
  }
}
