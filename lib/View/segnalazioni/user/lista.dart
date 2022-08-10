import 'segnalazione_card.dart';
import '/Model/segnalazione.dart';
import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';

class ListaSegnalazioni extends StatelessWidget {
  final _list = <SegnalazioneCard>[];
  List<Segnalazione> lista = <Segnalazione>[];

  ListaSegnalazioni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO qui va inserito il getter di list
    return ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        children: _list);
  }

  List<SegnalazioneCard> fillCard(List<Segnalazione> lista) {
    List<SegnalazioneCard> temp = <SegnalazioneCard>[];
    if (lista.isNotEmpty) {
      for (int i = 0; i < lista.length; i++) {
        temp[i].segnalazione.date = lista[i].date;
        temp[i].segnalazione.gravita = lista[i].gravita;
        temp[i].segnalazione.testo = lista[i].testo;
      }
    }
    return temp;
  }
}
