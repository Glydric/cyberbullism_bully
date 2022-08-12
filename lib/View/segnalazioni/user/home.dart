import '/Model/user.dart';
import 'card_aggiunta.dart';
import 'package:flutter/material.dart';

class PsycoSegnalazione extends StatefulWidget {
  final User user;
  const PsycoSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<PsycoSegnalazione> createState() => _PsycoSegnalazioneState();
}

class _PsycoSegnalazioneState extends State<PsycoSegnalazione> {
  bool _isWriting = false;
  // Future<List<SegnalazioneCard>> fillCards() => DbPsyConnector.getSegnalazioni()
  //     .then((List<Segnalazione> x) => x.map(SegnalazioneCard.new).toList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [if (_isWriting) CardAggiunta(widget.user.email)]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (() => setState(
            () => _isWriting ? _isWriting = false : _isWriting = true)),
      ),
    );
  }
}
