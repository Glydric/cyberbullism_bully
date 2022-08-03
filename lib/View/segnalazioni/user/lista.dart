import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';

class ListaSegnalazioni extends StatelessWidget {
  //Ancora non inizializzata
  final _list = <Widget>[
    Text('Segnalazione 1'),
    Text('Segnalazione 2'),
    Text('Segnalazione 3'),
  ];
  ListaSegnalazioni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO qui va inserito il getter di list
    return ListView(
      padding: const EdgeInsets.all(8),
      children: _list,
    );
  }
}
