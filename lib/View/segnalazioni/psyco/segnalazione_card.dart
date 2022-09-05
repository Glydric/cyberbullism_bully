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
  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        margin: const EdgeInsets.all(4),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: gravityColour(widget.segnalazione.gravita),
            ),
            title: Text(
              widget.segnalazione.testo,
              maxLines: 5,
            ),
            trailing: Column(
              children: [
                Text(data(widget.segnalazione.data)),
                Text(ora(widget.segnalazione.data)),
              ],
            ),
            onTap: () => {}
            //TODO Azione che avviene quando si tocca la lista
            ),
      );

  Color gravityColour(int gravity) {
    switch (gravity) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        {
          throw Exception("Gravità non corretta");
        }
    }
  }

/*
     10/08/2022_--:-- AM
    [0123456789012345678] posizioni dei caratteri
*/ //partendo dalla 11 posizione escludo lo spazio tra la data e l'ora

  String ora(String input) => input.substring(11);

  String data(String input) => input.substring(0, 10);
}
