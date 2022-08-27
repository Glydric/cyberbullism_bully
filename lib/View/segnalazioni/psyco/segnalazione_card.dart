import 'package:flutter/material.dart';
import 'lista.dart';
import '/Model/segnalazione.dart';

class SegnalazioneCard extends StatefulWidget {
  final Segnalazione segnalazione;

  const SegnalazioneCard(this.segnalazione, {Key? key}) : super(key: key);

  @override
  State<SegnalazioneCard> createState() => _SegnalazioneCardState();
}

class _SegnalazioneCardState extends State<SegnalazioneCard> {

  @override
  Widget build(BuildContext context) =>
      /* Padding( 
    padding: EdgeInsets.all(12.0),
   
    child: Container(
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
      )
      );
      */

      Card(
          margin: EdgeInsets.all(10),
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
                  Text(data(widget.segnalazione.orario)),
                  Text(ora(widget.segnalazione.orario)),
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
              onTap: () => {}
              /*
              TODO
              Azione che avviene quando si tocca la lista
              onLongPressed() -> azione dopo che si tiene premuto
              */
              ));

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

/*
     10/08/2022_--:-- AM
    [0123456789012345678] posizioni dei caratteri
  
*/
  String ora(String input) {
    String orario = "";
    if (input != null) {
      //partendo dalla 11 posizione escludo lo spazio tra la data e l'ora
      orario = input.substring(11);
    }
    return orario;
  }

  String data(String input) {
    String data = "";
    if (input != null) {
      data = input.substring(0, 10);
    }
    return data;
  }

  deleteItem(List lista, int index) {
    int indice = 0;
  }
}
