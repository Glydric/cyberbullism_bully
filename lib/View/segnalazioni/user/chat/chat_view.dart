import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Model/connect_db/user_db_connector.dart';
import '/Model/chat/chat.dart';
import 'message_card.dart';

/// La schermata che consente di portare avanti una chat con un utente
class ChatView extends StatefulWidget {
  final String otherEmail;

  final User user;

  const ChatView(this.user, this.otherEmail, {Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.otherEmail)),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: UserDbConnector.getMessagesOf(
                            widget.user, widget.otherEmail)
                        .then(Chat.fromList),
                    builder: (_, AsyncSnapshot<Chat> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.requireData.messages.length,
                                itemBuilder: (_, int _index) => MessageCard(
                                    snapshot.requireData.messages[_index]),
                              )
                            : const Center(
                                child: CircularProgressIndicator.adaptive()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  decoration:
                      const InputDecoration(hintText: "Inserire il messaggio"),
                  maxLines: 5,
                  minLines: 1,
                ),
              )
            ],
          ),
        ),
      );
}
