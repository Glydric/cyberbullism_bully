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
  Widget build(BuildContext context) => Container(
        color: const Color.fromARGB(214, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          //Questa è la riga che prende tutto lo spazio in larghezza
          child: Row(children: [
            //Questo è il primo elemento della Row, ovvero il container che contiene la label colorata con la gravità

            //Forse l'Expanded deve essere impostato su una COLONNA e non un container
            Expanded(
              child: Container(
                //Vogliamo che il container (etichetta) nella colonna sia "Expanded", ovvero venga occupata tutta, ma che la sua
                //larghezza nella riga sia impostata ad un valore fisso (10 o diverso).
                width: 10,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: gravityColour(widget.segnalazione.gravita),
                ),
              ),
            ),
            const Spacer(flex: 1),

            //Questa è la parte dove c'è il testo. Flessibile e può prendere meno spazio di quello che ha, o può aumentare
            //in base alla grandezza del testo in entrata
            Expanded(
              flex: 2,
              child: (
                  //Probabilmente può essere utile inserire qui un padding... da verificare
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.segnalazione.testo),
              )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //Tiene il testo in alto
                mainAxisAlignment: MainAxisAlignment.start,
                //A destra
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text((widget.segnalazione.orario).toString()),
                ],
              ),
            ),
          ]),
        ),
      );

  Color gravityColour(int gravity) {
    switch (gravity) {//TODO inserire i colori corretti
      case 0:
        {
          return const Color.fromARGB(200, 62, 62, 62);
        }
      case 1:
        {
          return const Color.fromARGB(255, 130, 223, 42);
        }

      case 2:
        {
          return const Color.fromARGB(255, 245, 245, 9);
        }

      case 3:
        {
          return const Color.fromARGB(255, 223, 156, 0);
        }

      case 4:
        {
          return const Color.fromRGBO(255, 43, 190, 1);
        }

      default:
        {
          throw Exception("Gravità non corretta");
        }
    }
  }
}
