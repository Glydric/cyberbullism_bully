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
  final TextEditingController myController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        //La card l'ho definita come un Expanded Widget, in modo da prendere tutto lo spazio
        //del suo container.. Possibile aspetto da rivedere. Forse è completamente da rimuovere
          child: Expanded (child: Card( 
            elevation: 2,
            color: const Color.fromARGB(197, 255, 153, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //La FittedBox tiene conto della grandezza del widget che c'è dentro
              //e si autodimensiona
              child: FittedBox(
                //.cover è la modalità col quale si espande all'interno dello spazio concesso
                fit: BoxFit.cover,
                child: TextFormField(
                    controller: myController,
                    keyboardType: TextInputType.multiline,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        label: Text("Digitare un max di 5000 caratteri"))),
              ),
            ),
          ),
  ),
  );
}
