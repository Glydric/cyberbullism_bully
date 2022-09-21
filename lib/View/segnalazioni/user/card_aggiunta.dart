import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';
import 'package:flutter/material.dart';

import '/Model/connect_db/login_exception.dart';
import '/Model/user.dart';

class CardAggiunta extends StatefulWidget {
  final User user;
  const CardAggiunta(this.user, {Key? key}) : super(key: key);

  @override
  State<CardAggiunta> createState() => _CardAggiuntaState();
}

///Classe che definisce l'interfaccia per l'aggiunta di una segnalazione
class _CardAggiuntaState extends State<CardAggiunta> {
  final TextEditingController _textController = TextEditingController();
  String? _errorText;

  final tipiDiGravita = List.of(const <String>[
    "Piccolo Problema",
    "Gravità alta",
    "Pericolo!",
    "Non definita",
  ]);

  late String _dropdownElement;

  List<DropdownMenuItem<String>> get getDropdownElements => tipiDiGravita
      .map(
        (e) => DropdownMenuItem(
          child: Text(e),
          value: e,
        ),
      )
      .toList();

  @override
  void initState() {
    _dropdownElement = tipiDiGravita.elementAt(3);
    super.initState();
  }

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: 5000,
                  minLines: 4,
                  maxLines: 10,
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorText: _errorText,
                    label: const Text("Inserire la segnalazione"),
                  ),
                ),
                Row(
                  children: [
                    const Text("Tipo di segnalazione "),
                    DropdownButton(
                      value: _dropdownElement,
                      items: getDropdownElements,
                      onChanged: (String? value) =>
                          setState(() => _dropdownElement = value!),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.pop(context, false),
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

  void send() async {
    try {
      await UserDbConnector.addSegnalazioneFromUser(
        widget.user,
        _textController.text,
        tipiDiGravita.indexOf(_dropdownElement)
      );
      Navigator.pop(context, true);
    } on LoginException catch (e) {
      _errorText = e.toString();
    }
  }
}
