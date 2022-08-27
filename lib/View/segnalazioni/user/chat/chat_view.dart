import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';

class ChatView extends StatefulWidget {
  String userEmail;

  ChatView(this.userEmail, {Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Chat chat = Chat();


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(chat.otherEmail)),
      body: Container(
        child: Text(chat.otherEmail),
      ));
}
