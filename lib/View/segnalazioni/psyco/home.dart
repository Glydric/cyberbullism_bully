import 'package:flutter/material.dart';

import '../psyco/segnalazione_card.dart';
import '/Model/connect_db/psy_connector.dart';
import '/Model/segnalazione.dart';
import 'lista.dart';
import 'segnalazione_card.dart';

class HomeSegnalazioni extends StatefulWidget {
  const HomeSegnalazioni({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSegnalazioniState();
}

class _HomeSegnalazioniState extends State<HomeSegnalazioni> {

  Future<List<SegnalazioneCard>> fillCards() => DbPsyConnector.getSegnalazioni()
      .then((List<Segnalazione> x) => x.map(SegnalazioneCard.new).toList());
      //TODO questo non deve essere visibile dallo psicologo

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: [
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
      );
}
