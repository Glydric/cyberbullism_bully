import '/Model/connect_db/psy_connector.dart';
import '/Model/segnalazione.dart';
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

  Future<List<SegnalazioneCard>> fillCards() => DbPsyConnector.getSegnalazioni()
      .then((List<Segnalazione> x) => x.map(SegnalazioneCard.new).toList());


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: Stack(
            children: [
              if (_isWriting) const CardAggiunta(),
              FutureBuilder(
                future: fillCards(),
                builder:
                    (context, AsyncSnapshot<List<SegnalazioneCard>> snapshot) =>
                        snapshot.hasData
                            ? ListaSegnalazioni(snapshot.requireData)
                            : const CircularProgressIndicator.adaptive(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (() => setState(
              () => _isWriting ? _isWriting = false : _isWriting = true)),
        ),
      );
}
}
