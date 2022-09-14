import 'dart:async';

import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';
import '/Model/connect_db/psyco_db_connector.dart';
import '/Model/user.dart';
import 'chat/psyco_chat_list.dart';
import 'segnalazione_list.dart';

class PsycoSegnalazioni extends StatefulWidget {
  final User user;

  const PsycoSegnalazioni(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  late final Timer timer;

  ///ottiene la lista degli ultimi messaggi
  get chats => PsycoDbConnector.getLastMessages(widget.user)
      .then((messages) => messages.map(Chat.singleMessage).toList());

  void updateChat() => setState(() {
        chats;
      });

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateChat(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => toPage(ListaSegnalazioni(widget.user)),
        ),
        body: Center(
          child: FutureBuilder(
            future: chats,
            builder: (_, AsyncSnapshot<List<Chat>> snapshot) =>
                snapshot.hasError
                    ? Column(
                        children: const [
                          Icon(Icons.signal_wifi_bad),
                          Text("Errore di connessione"),
                        ],
                      )
                    : snapshot.hasData
                        ? PsycoChatList(widget.user, snapshot.requireData)
                        : const CircularProgressIndicator.adaptive(),
          ),
        ),
      );

  toPage(Widget page) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page,
      ));
}
