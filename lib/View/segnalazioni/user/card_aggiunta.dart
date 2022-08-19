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
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Card(
          elevation: 2,
          color: const Color.fromARGB(197, 255, 153, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 5000,
              minLines: 4,
              maxLines: 10,
              controller: _textController,
              keyboardType: TextInputType.multiline,
              autocorrect: false,
              decoration: const InputDecoration(
                label: Text("Scrivere una segnalazione"),
              ),
            ),
          ),
        ),
      );
}
