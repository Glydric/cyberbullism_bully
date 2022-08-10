import 'package:flutter/material.dart';

import '/Model/segnalazione.dart';

class SegnalazioneCard extends Container {
  SegnalazioneCard(Segnalazione segnalazione) {
    Container(
      child: Text(segnalazione.testo),
    );
  } //TODO implementare il costruttore che prende una segnalazione e crea una card
}
