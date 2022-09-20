import 'dart:async';

import 'package:cyberbullism_bully/Model/connect_db/psyco_db_connector.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/View/connection_error_ui.dart';
import '../../user/chat/message_card.dart';
import '/Model/chat/chat.dart';

int get _maximumTextLength => 500;

/// La schermata che consente di portare avanti una chat con un utente
class PsycoChatView extends StatefulWidget {
  final User user;
  final String otherEmail;

  const PsycoChatView(this.user, this.otherEmail, {Key? key}) : super(key: key);

  @override
  State<PsycoChatView> createState() => PsycoChatViewState();
}

class PsycoChatViewState extends State<PsycoChatView> {
  final TextEditingController _textController = TextEditingController();
  late final Timer timer;

  Future<Chat> get messages =>
      PsycoDbConnector.getMessagesOf(widget.user, widget.otherEmail)
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
    PsycoDbConnector.sendMessage(
      widget.user,
      widget.otherEmail,
      _textController.text,
    );
    _textController.clear();
    updateChat();
  }

  @override
  void dispose() {
    timer.cancel();
    _textController.dispose();
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
        appBar: AppBar(title: Text(widget.otherEmail)),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: FutureBuilder(
                future: messages,
                builder: (_, AsyncSnapshot<Chat> snapshot) => snapshot.hasError
                    ? const ConnectionErrorUI()
                    : snapshot.hasData
                        ? ListView.builder(
                            reverse: true,
                            itemCount: snapshot.requireData.messages.length,
                            itemBuilder: (_, int _index) => MessageCard(
                              snapshot.requireData.messages[_index],
                              showDate: showDate(snapshot.requireData, _index),
                              isLast: _index == 0,
                            ),
                          )
                        : Container(),
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

  bool showDate(Chat chat, int _index) =>
      _index + 1 == chat.messages.length ||
      chat.messages[_index].yearMonthDate !=
          chat.messages[_index + 1].yearMonthDate;
}
