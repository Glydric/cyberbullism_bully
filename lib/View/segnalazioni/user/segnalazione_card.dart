import 'package:flutter/material.dart';

import '/Model/segnalazione.dart';

class SegnalazioneCard extends StatefulWidget {
  final Segnalazione segnalazione;

  const SegnalazioneCard(this.segnalazione, {Key? key}) : super(key: key);

  @override
  State<SegnalazioneCard> createState() => _SegnalazioneCardState();
}

class _SegnalazioneCardState extends State<SegnalazioneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color.fromARGB(214, 255, 255, 255),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: gravityColour(widget.segnalazione.gravita),
            ),
          ),
          const Spacer(),
          Expanded(child: Text(widget.segnalazione.testo)),
          const Spacer(),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text((widget.segnalazione.orario).toString())],
            ),
          )
        ],
      ),
    );
  }

  Color gravityColour(int gravity) {
    switch (gravity) {
      case 0:
        {
          return Color.fromARGB(200, 62, 62, 62);
        }
      case 1:
        {
          return Color.fromARGB(255, 130, 223, 42);
        }

      case 2:
        {
          return Color.fromARGB(255, 245, 245, 9);
        }

      case 3:
        {
          return Color.fromARGB(255, 223, 156, 0);
        }

      case 4:
        {
          return Color.fromRGBO(255, 43, 190, 1);
        }

      default:
        {
          throw Exception("Gravità non corretta");
        }
    }
  }
}
