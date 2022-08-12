import 'package:cyberbullism_bully/Model/segnalazione.dart';
import 'package:flutter/material.dart';

class CardAggiunta extends StatefulWidget {
  final String email;
  const CardAggiunta(this.email, {Key? key}) : super(key: key);

  @override
  State<CardAggiunta> createState() => _CardAggiuntaState();
}

///Classe che definisce l'interfaccia per l'aggiunta di una segnalazione
class _CardAggiuntaState extends State<CardAggiunta> {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: const SizedBox(
          height: 200,
          width: 300,
          child: Card(
            elevation: 2,
            color: Colors.orange,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(""),
              ),
            ),
          ),
        ),
      );
}
