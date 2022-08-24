import 'package:flutter/material.dart';

import '/Model/connect_db/user_db_connector.dart';
import '/Model/user.dart';
import '../../../Model/chat/chat.dart';
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
    List<Message> list = await UserDbConnector.getMessagesOf(widget.user);
    String oldEmail = list[0].otherEmail;

    List<Chat> newList = <Chat>[];
    int _index = 0;

    for (Message m in list) {
      if (oldEmail == m.otherEmail) {
        newList[_index].messages.add(m);
      } else {
        newList.add(Chat());
      }

      oldEmail = m.otherEmail;
    }

    return newList.map(ChatCard.new).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: getChats(),
          builder: (_, AsyncSnapshot<List<ChatCard>> snapshot) =>
              snapshot.hasData
                  ? ListaChat(snapshot.requireData)
                  : const CircularProgressIndicator.adaptive(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
                  context: context,
                  builder: (_) => CardAggiunta(widget.user.email),
                )),
      );
}
