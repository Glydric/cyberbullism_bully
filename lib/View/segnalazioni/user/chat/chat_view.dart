import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';

class ChatView extends StatefulWidget {
  Chat chat;

  ChatView(this.chat, {Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(widget.chat.otherEmail)),
      body: Container(
        child: Text(widget.chat.otherEmail),
      ));
}
