import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';
import 'chat_card.dart';
import 'chat_view.dart';

class ListaChat extends StatefulWidget {
  final List<Chat> chats;

  const ListaChat(this.chats, {Key? key}) : super(key: key);

  @override
  State<ListaChat> createState() => _ListaChatState();
}

class _ListaChatState extends State<ListaChat> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (_, int _index) => GestureDetector(
          onTap: () => toChatPage(widget.chats[_index].otherEmail),
          child: ChatCard(widget.chats[_index]),
        ),
      );

  toChatPage(String otherEmail) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatView(otherEmail),
      ));
}
