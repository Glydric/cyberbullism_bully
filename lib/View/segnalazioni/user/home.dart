import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/chat/chat.dart';

import 'package:cyberbullism_bully/View/connection_error_ui.dart';
import 'package:cyberbullism_bully/View/chat/user/chat_list.dart';
import 'package:cyberbullism_bully/View/segnalazioni/user/card_aggiunta.dart';

class UserSegnalazione extends StatefulWidget {
  final User user;
  const UserSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<UserSegnalazione> createState() => _UserSegnalazioneState();
}

class _UserSegnalazioneState extends State<UserSegnalazione> {
  late final Timer timer;

  ///ottiene la lista degli ultimi messaggi
  late Future<List<Chat>> chats;

  void updateChat() => setState(() {
        chats = UserDbConnector.getLastMessages(widget.user)
            .then((messages) => messages.map(Chat.singleMessage).toList());
      });

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    updateChat();
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => updateChat(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: chats,
          builder: (_, AsyncSnapshot<List<Chat>> snapshot) => snapshot.hasError
              ? const Center(child: ConnectionErrorUI())
              : snapshot.hasData
                  ? ChatList(widget.user, snapshot.requireData)
                  : const Center(child: CircularProgressIndicator.adaptive()),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.send),
          label: const Text("Invia Segnalazione"),
          onPressed: addSegnalazione,
        ),
      );

  void addSegnalazione() => showDialog(
        context: context,
        builder: (_) => CardAggiunta(widget.user),
      ).then(
        (value) => value == null
            ? null
            : showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: value
                      ? const Text("Segnalazione inserita ")
                      : const ConnectionErrorUI(),
                ),
              ),
      );
}
