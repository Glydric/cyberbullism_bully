import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';

class ListaSegnalazione extends StatefulWidget {
  final String messaggio = "";
  final int gravita = 0;

  const ListaSegnalazione({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaSegnalazioneState();
}

class ListaSegnalazioneState extends State<ListaSegnalazione> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
