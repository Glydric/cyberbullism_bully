import 'package:flutter/material.dart';
import '/Model/segnalazione.dart';

class SegnalazioneCard extends StatefulWidget {
  final Segnalazione segnalazione;

  const SegnalazioneCard(this.segnalazione, {Key? key}) : super(key: key);

  @override
  State<SegnalazioneCard> createState() => _SegnalazioneCardState();
}

/// La singola carta che specifica una segnalazione nella lista
class _SegnalazioneCardState extends State<SegnalazioneCard> {
  Color get gravityColor {
    switch (widget.segnalazione.gravita) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        throw Exception("Gravità non corretta");
    }
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(backgroundColor: gravityColor),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(widget.segnalazione.nomeCognome),
          ),
          subtitle: Text(widget.segnalazione.testo),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.segnalazione.yearMonth),
              Text(widget.segnalazione.hourDay),
            ],
          ),
        ),
      );
}
