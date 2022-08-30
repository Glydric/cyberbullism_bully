import 'package:flutter/material.dart';

import '/Model/connect_db/psyco_db_connector.dart';
import '../psyco/segnalazione_card.dart';
import '/Model/segnalazione.dart';
import 'lista.dart';
import 'segnalazione_card.dart';

class PsycoSegnalazioni extends StatefulWidget {
  const PsycoSegnalazioni({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  Future<List<SegnalazioneCard>> fillCards() =>
      PsycoDbConnector.getSegnalazioni()
          .then((List<Segnalazione> l) => l.map(SegnalazioneCard.new).toList());
  //TODO questo non deve essere visibile dallo psicologo

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(children: [
            FutureBuilder(
              future: fillCards(),
              builder:
                  (_, AsyncSnapshot<List<SegnalazioneCard>> snapshot) =>
                      snapshot.hasData
                          ? ListaSegnalazioni(snapshot.requireData)
                          : const CircularProgressIndicator.adaptive(),
            )
          ]),
        ),
      );
}
