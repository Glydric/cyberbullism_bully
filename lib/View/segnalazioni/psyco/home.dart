import 'dart:async';

import '/View/connection_error_ui.dart';
import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';
import '/Model/connect_db/psyco_db_connector.dart';
import '/Model/user.dart';
import '../../chat/psyco/chat_list.dart';

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
      const Duration(milliseconds: 100),
      (_) => updateChat(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: FutureBuilder(
            future: chats,
            builder: (_, AsyncSnapshot<List<Chat>> snapshot) =>
                snapshot.hasError
                    ? const ConnectionErrorUI()
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
