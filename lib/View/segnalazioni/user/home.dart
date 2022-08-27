import 'package:flutter/material.dart';

import '/Model/connect_db/user_db_connector.dart';
import '/Model/user.dart';
import '/Model/chat/chat.dart';
import '/Model/chat/message.dart';

import 'chat/lista_chat.dart';
import 'chat/chat_card.dart';
import 'card_aggiunta.dart';

class UserSegnalazione extends StatefulWidget {
  final User user;
  const UserSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<UserSegnalazione> createState() => _UserSegnalazioneState();
}

class _UserSegnalazioneState extends State<UserSegnalazione> {
  Future<List<ChatCard>> getChats() async {
    //ottiene la lista degli ultimi messaggi
    return UserDbConnector.getLastMessages(widget.user).then(
        (value) => value.map(Chat.singleMessage).map(ChatCard.new).toList());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: FutureBuilder(
            future: getChats(),
            builder: (_, AsyncSnapshot<List<ChatCard>> snapshot) =>
                snapshot.hasData
                    ? ListaChat(snapshot.requireData)
                    : const CircularProgressIndicator.adaptive(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
                  context: context,
                  builder: (_) => CardAggiunta(widget.user.email),
                )),
      );
}
