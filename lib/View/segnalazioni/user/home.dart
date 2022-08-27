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
    //ottiene la lista di messaggi
    List<Message> rawMessageList = await UserDbConnector.getMessagesOf(widget.user);
    String oldEmail = rawMessageList[0].otherEmail;

    // trasforma una lista di messaggi in una lista di chat
    List<Chat> chatList = [Chat()];
    int _index = 0;

    for (Message m in rawMessageList) {//TODO sviluppare meglio
      if (oldEmail != m.otherEmail) {
        chatList.add(Chat());
        oldEmail = m.otherEmail;
        _index++;
      }

      chatList[_index].messages.add(m);
    }

    // trasforma la lista di chat in una lista di ChatCard e la ritorna
    return chatList.map(ChatCard.new).toList();
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
