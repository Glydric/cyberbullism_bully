import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/connect_db/psyco_db_connector.dart';
import '/Model/segnalazione.dart';
import 'segnalazione_list.dart';

class PsycoSegnalazioni extends StatefulWidget {
  final User user;

  const PsycoSegnalazioni(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  Future<List<Segnalazione>> get fillCards =>
      PsycoDbConnector.getSegnalazioni(widget.user);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(children: [
            FutureBuilder(
              future: fillCards,
              builder: (_, AsyncSnapshot<List<Segnalazione>> snapshot) =>
                  snapshot.hasError
                      ? Text(snapshot.error.toString())
                      : snapshot.hasData
                          ? ListaSegnalazioni(widget.user, snapshot.requireData)
                          : const CircularProgressIndicator.adaptive(),
            )
          ]),
        ),
      );
}
