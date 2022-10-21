import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/View/segnalazioni/user/home.dart';
import 'package:cyberbullism_bully/View/connection_error_ui.dart';
import 'package:cyberbullism_bully/View/chat/psyco/chat_list.dart';

import 'package:cyberbullism_bully/Model/chat/chat.dart';
import 'package:cyberbullism_bully/Model/connect_db/psyco_db_connector.dart';
import 'package:cyberbullism_bully/Model/user.dart';

class PsycoSegnalazioni extends UserSegnalazione {
  const PsycoSegnalazioni(User user, {Key? key}) : super(user, key: key);

  @override
  State<UserSegnalazione> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends UserSegnalazioneState {
  @override
  void updateChat() => setState(() {
        try {
          chats = PsycoDbConnector.getLastMessages(widget.user)
              .then((messages) => messages.map(Chat.singleMessage).toList());
        } catch (_) {}
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: FutureBuilder(
            future: chats,
            builder: (_, AsyncSnapshot<List<Chat>> snapshot) =>
                snapshot.hasError
                    ? const Center(child: ConnectionErrorUI())
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
