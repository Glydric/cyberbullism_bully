import 'package:cyberbullism_bully/View/connection_error_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cyberbullism_bully/Model/connect_db/web_socket/user.dart';
import 'package:cyberbullism_bully/View/chat/message_card.dart';

import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/chat/chat.dart';

int get _maximumTextLength => 500;

/// La schermata che consente di portare avanti una chat con un utente
class ChatView extends StatefulWidget {
  final User user;
  final String otherEmail;

  const ChatView(this.user, this.otherEmail, {Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  final TextEditingController textController = TextEditingController();
  late final UserWS ws;

  get errorText => textController.text.length == _maximumTextLength
      ? "Impossibile inserire altri caratteri"
      : null;

  ///Fornisce il valore da inserire nel campo maxLength cosi da mostrare il massimo all'occorrenza
  get seeMaxLength => textController.text.length > _maximumTextLength - 50
      ? _maximumTextLength
      : null;

  void sendMessage() => ws.sendMessage(textController.text);

  void send() {
    if (RegExp(r"[\S]").hasMatch(textController.text)) {
      sendMessage();
    }
    textController.clear();
  }

  void setWebSocket() => ws = UserWS(widget.user, widget.otherEmail);

  @override
  void dispose() {
    textController.dispose();
    ws.close();
    super.dispose();
  }

  @override
  void initState() {
    setWebSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.otherEmail)),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: StreamBuilder(
                stream: ws.stream,
                builder: (context, snapshot) => snapshot.hasError
                    ? const ConnectionErrorUI()
                    : snapshot.hasData
                        ? listChatBuilder(snapshot.data)
                        : const CircularProgressIndicator.adaptive(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                maxLength: seeMaxLength,
                onChanged: (s) => setState(() => errorText),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_maximumTextLength)
                ],
                textAlignVertical: TextAlignVertical.center,
                controller: textController,
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
                    onPressed: textController.text.isNotEmpty ? send : null,
                  ),
                ),
                maxLines: 4,
                minLines: 1,
              ),
            ),
          ]),
        ),
      );

  bool showDate(Chat chat, int _index) =>
      _index + 1 == chat.messages.length ||
      chat.messages[_index].yearMonthDate !=
          chat.messages[_index + 1].yearMonthDate;

  ListView listChatBuilder(body) {
    final chat = Chat.fromJsonString(body);

    return ListView.builder(
      reverse: true,
      itemCount: chat.messages.length,
      itemBuilder: (_, int _index) => MessageCard(
        chat.messages[_index],
        showDate: showDate(chat, _index),
        isLast: _index == 0,
      ),
    );
  }
}
