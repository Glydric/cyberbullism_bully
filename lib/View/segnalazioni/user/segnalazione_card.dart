import 'package:flutter/material.dart';

import '/Model/segnalazione.dart';

class SegnalazioneCard extends StatelessWidget {
  Segnalazione segnalazione;
  SegnalazioneCard(this.segnalazione, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(segnalazione.testo),
    );
  } //TODO implementare il costruttore che prende una segnalazione e crea una card
}
