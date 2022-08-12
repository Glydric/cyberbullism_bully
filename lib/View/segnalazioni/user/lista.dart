// ignore_for_file: prefer_final_fields, unused_field

import 'package:cyberbullism_bully/Model/connect_db/psy_connector.dart';

import 'segnalazione_card.dart';
import '/Model/segnalazione.dart';
import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';

class ListaSegnalazioni extends StatelessWidget {
  DbPsyConnector psyConnector = new DbPsyConnector();
  List<Segnalazione> lista =
      DbPsyConnector.getSegnalazioni() as List<Segnalazione>;

  ListaSegnalazioni({Key? key}) : super(key: key);

  List<SegnalazioneCard> fillCard(List<Segnalazione> myList) =>
      myList.map(SegnalazioneCard.new).toList();
  //ci dovrebbe essere il metodo List.map da vedere meglio..
  // List<SegnalazioneCard> temp = <SegnalazioneCard>[];
  // if (myList.isNotEmpty) {
  //   for (int i = 0; i < lista.length; i++) {
  //     temp[i].segnalazione.orario = myList[i].orario;
  //     temp[i].segnalazione.gravita = myList[i].gravita;
  //     temp[i].segnalazione.testo = myList[i].testo;
  //     temp[i].segnalazione.email = myList[i].email;
  //   }
  // }
  // return temp;

  @override
  Widget build(BuildContext context) {
    List<SegnalazioneCard> _list = fillCard(lista);

    // lista anche relativamente lunga e che
    // riserva lo stesso spazio per ogni Container (segnalazione)

    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            color: Color.fromARGB(214, 255, 255, 255),
            child: Center(child: Text('${_list[index]}')),
          );
        });

    // return ListView(
    //     scrollDirection: Axis.vertical,
    //     padding: const EdgeInsets.all(8),
    //     children: <SegnalazioneCard>[

    //     ]
    //     );
  }
}
