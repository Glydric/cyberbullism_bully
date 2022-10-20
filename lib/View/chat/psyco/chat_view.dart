import 'package:cyberbullism_bully/Model/connect_db/web_socket/psyco.dart';
import 'package:cyberbullism_bully/View/chat/user/chat_view.dart';
import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/user.dart';

/// La schermata che consente di portare avanti una chat con un utente
class PsycoChatView extends ChatView {
  const PsycoChatView(User user, String otherEmail, {Key? key})
      : super(user, otherEmail, key: key);

  @override
  ChatViewState createState() => PsycoChatViewState();
}

class PsycoChatViewState extends ChatViewState {
  @override
  void setWebSocket() => ws = PsycoWS(widget.user, widget.otherEmail);
}
