import 'dart:async';

import 'package:cyberbullism_bully/View/chat/user/chat_view.dart';
import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/connect_db/psyco_db_connector.dart';
import 'package:cyberbullism_bully/Model/chat/chat.dart';

/// La schermata che consente di portare avanti una chat con un utente
class PsycoChatView extends ChatView {
  const PsycoChatView(User user, String otherEmail, {Key? key})
      : super(user, otherEmail, key: key);

  @override
  // ignore: no_logic_in_create_state
  ChatViewState createState() => PsycoChatViewState();
}

class PsycoChatViewState extends ChatViewState {
  @override
  Future<Chat> get messages =>
      PsycoDbConnector.getMessagesOf(widget.user, widget.otherEmail)
          .then(Chat.fromList);

  @override
  void sendMessage() {
    PsycoDbConnector.sendMessage(
      widget.user,
      widget.otherEmail,
      textController.text,
    );
  }
}
