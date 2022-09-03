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
    // Clean up the controller when the widget is removed from the widget tree
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          elevation: 10,
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 5000,
                  minLines: 4,
                  maxLines: 10,
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      label: Text("Inserire la segnalazione")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annulla"),
                    ),
                    MaterialButton(
                      onPressed: send,
                      child: const Text("Invia"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  void send() {
    //TODO logic
  }
}
