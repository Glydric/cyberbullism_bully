import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/Model/user.dart';
import '/Model/connect_db/user_db_connector.dart';
import '/Model/chat/chat.dart';
import 'message_card.dart';

/// La schermata che consente di portare avanti una chat con un utente
class ChatView extends StatefulWidget {
  final User user;
  final String otherEmail;

  const ChatView(this.user, this.otherEmail, {Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textController = TextEditingController();

  int get _maximumTextLength => 500;

  Future<Chat> get messages =>
      UserDbConnector.getMessagesOf(widget.user, widget.otherEmail)
          .then(Chat.fromList);

  get errorText => _textController.text.length == _maximumTextLength
      ? "Impossibile inserire altri caratteri"
      : null;

  ///Fornisce il valore da inserire nel campo maxLength cosi da mostrare il massimo all'occorrenza
  get seeMaxLength => _textController.text.length > _maximumTextLength - 50
      ? _maximumTextLength
      : null;

  void updateChat() => setState(() {
        messages;
      });

  void send() {
    //TODO inviare il messaggio
    _textController.clear;
    updateChat();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.otherEmail)),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: messages,
                  builder: (_, AsyncSnapshot<Chat> snapshot) => snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.requireData.messages.length,
                          itemBuilder: (_, int _index) => MessageCard(
                              snapshot.requireData.messages[_index]),
                        )
                      : Container(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: seeMaxLength,
                onChanged: (s) => setState(() => errorText),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_maximumTextLength)
                ],
                textAlignVertical: TextAlignVertical.center,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Inserire il messaggio",
                  helperText:
                      "", // fornisce uno spazio in modo che all'aggiunta degli altri elementi il textfield non si alzi
                  errorText: errorText,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(Icons.send),
                    onPressed: send,
                  ),
                ),
                maxLines: 4,
                minLines: 1,
              ),
            ),
          ]),
        ),
      );
}
