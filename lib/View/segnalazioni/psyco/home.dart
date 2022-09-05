import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/connect_db/psyco_db_connector.dart';
import '../psyco/segnalazione_card.dart';
import '/Model/segnalazione.dart';
import 'lista.dart';

class PsycoSegnalazioni extends StatefulWidget {
  final User user;

  const PsycoSegnalazioni(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  Future<List<SegnalazioneCard>> get fillCards =>
      PsycoDbConnector.getSegnalazioni(widget.user)
          .then((List<Segnalazione> l) => l.map(SegnalazioneCard.new).toList());
  //TODO questo non deve essere visibile dallo psicologo

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(children: [
            FutureBuilder(
              future: fillCards,
              builder: (_, AsyncSnapshot<List<SegnalazioneCard>> snapshot) =>
                  snapshot.hasError
                      ? Text(snapshot.error.toString())
                      : snapshot.hasData
                          ? ListaSegnalazioni(snapshot.requireData)
                          : const CircularProgressIndicator.adaptive(),
            )
          ]),
        ),
      );
}
