import 'dart:async';

import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';
import 'package:cyberbullism_bully/View/connection_error_ui.dart';
import 'package:cyberbullism_bully/View/segnalazioni/psyco/chat/psyco_chat_view.dart';
import 'package:flutter/material.dart';

import '/Model/connect_db/psyco_db_connector.dart';
import '/Model/segnalazione.dart';
import '/Model/user.dart';
import 'segnalazione_card.dart';

/// lista anche relativamente lunga e che
/// riserva lo stesso spazio per ogni Container (segnalazione)
class ListaSegnalazioni extends StatefulWidget {
  final User user;

  const ListaSegnalazioni(this.user, {Key? key}) : super(key: key);

  @override
  State<ListaSegnalazioni> createState() => _ListaSegnalazioniState();
}

class _ListaSegnalazioniState extends State<ListaSegnalazioni> {
  late final Timer timer;

  Future<List<Segnalazione>> get fillCards =>
      PsycoDbConnector.getSegnalazioni(widget.user);

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => updateSegnalazioni(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Lista Segnalazioni")),
        body: Center(
          child: FutureBuilder(
              future: fillCards,
              builder: (_, AsyncSnapshot<List<Segnalazione>> snapshot) =>
                  snapshot.hasError
                      ? const ConnectionErrorUI()
                      : snapshot.hasData
                          ? buildList(snapshot.requireData)
                          : const CircularProgressIndicator.adaptive()),
        ),
      );

  ListView buildList(List<Segnalazione> list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, int _index) => GestureDetector(
          onTap: () => openChat(list[_index]),
          child: SegnalazioneCard(list[_index]),
        ),
      );

  openChat(Segnalazione segnalazione) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Attenzione!"),
        content: const Text(
            "Proseguendo la segnalazione verrà legata indissolubilmente a questo profilo e nessun altro psicologo potrà visualizzarla"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annulla"),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Prosegui"),
          ),
        ],
      ),
    );

    if (result) {
      try {
        PsycoDbConnector.presaInCarica(widget.user, segnalazione);
      } on LoginException catch (e) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              "Impossibile collegare il messaggio al proprio utente " +
                  e.toString(),
            ),
          ),
        );
      }
      toChat(segnalazione.email);
    }
  }

  void toChat(String email) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PsycoChatView(widget.user, email),
        ),
      );

  updateSegnalazioni() => setState(() {
        fillCards;
      });
}
