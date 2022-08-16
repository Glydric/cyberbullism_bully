import 'package:flutter/material.dart';

import '../psyco/segnalazione_card.dart';
import '/Model/connect_db/db_connector.dart';
import '/Model/segnalazione.dart';
import 'lista.dart';
import 'segnalazione_card.dart';

class PsycoSegnalazioni extends StatefulWidget {
  const PsycoSegnalazioni({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  Future<List<SegnalazioneCard>> fillCards() => DbConnector.getSegnalazioni()
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
