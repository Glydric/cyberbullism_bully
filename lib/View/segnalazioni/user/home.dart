import '../../../Model/segnalazione.dart';
import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';
import 'card_aggiunta.dart';
import 'lista.dart';
import 'segnalazione_card.dart';

class HomeSegnalazioni extends StatefulWidget {

  const HomeSegnalazioni({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSegnalazioniState();
}

class _HomeSegnalazioniState extends State<HomeSegnalazioni> {
  bool _isWriting = false;

  
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[ 
              _isWriting ? const CardAggiunta() : Container(),
              ListaSegnalazioni()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => setState(
              () => _isWriting ? _isWriting = false : _isWriting = true)),
          child: const Icon(Icons.add),
        ),
      );
}
