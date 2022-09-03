import 'dart:async';

import 'package:flutter/material.dart';

import '/Model/connect_db/user_db_connector.dart';
import '/Model/user.dart';
import '/Model/chat/chat.dart';

import 'chat/chat_list.dart';
import 'card_aggiunta.dart';

class UserSegnalazione extends StatefulWidget {
  final User user;
  const UserSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<UserSegnalazione> createState() => _UserSegnalazioneState();
}

class _UserSegnalazioneState extends State<UserSegnalazione> {
  late final Timer timer;

  ///ottiene la lista degli ultimi messaggi
  get chats => UserDbConnector.getLastMessages(widget.user)
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
      ((_) => updateChat()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: chats,
          builder: (_, AsyncSnapshot<List<Chat>> snapshot) => snapshot.hasData
              ? ListaChat(widget.user, snapshot.requireData)
              : const Center(child: CircularProgressIndicator.adaptive()),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
                  context: context,
                  builder: (_) => CardAggiunta(widget.user.email),
                )),
      );
}
