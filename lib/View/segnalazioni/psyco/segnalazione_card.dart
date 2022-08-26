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
        color: Color.fromARGB(212, 255, 255, 255),
        child: Card(
          
          elevation: 5,
          //Questa è la riga che prende tutto lo spazio in larghezza
          child: Row(children: [
            //Questo è il primo elemento della Row, ovvero il container che contiene la label colorata con la gravità

            
           
            Container(
                height: 30,
                width: 30,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: gravityColour(widget.segnalazione.gravita),
                ),
             
            ),       

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
    switch (gravity) {
      //TODO inserire i colori corretti
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
