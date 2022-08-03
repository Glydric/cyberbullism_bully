import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';
import 'card_aggiunta.dart';
import 'lista.dart';

class HomeSegnalazioni extends StatefulWidget {
  final String messaggio = "";
  final int gravita = 0;

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
              ListaSegnalazioni(),
              _isWriting ? const CardAggiunta() : Container()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => setState(
                  () => _isWriting ? _isWriting = false : _isWriting = true)
              // debugPrint(
              //     'Inserire qui la segnalazione "CARD"'); //TODO sostituire con la card
              ),
          child: const Icon(Icons.add),
        ),
      );
}
