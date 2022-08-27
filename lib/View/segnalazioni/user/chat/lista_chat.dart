import 'package:flutter/material.dart';

import 'chat_card.dart';
import 'chat_view.dart';

class ListaChat extends StatefulWidget {
  final List<ChatCard> chats;

  const ListaChat(this.chats, {Key? key}) : super(key: key);

  @override
  State<ListaChat> createState() => _ListaChatState();
}

class _ListaChatState extends State<ListaChat> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (_, int _index) => GestureDetector(
          onTap: () => toPage(ChatView(widget.chats[_index].chat)),
          child: widget.chats[_index],
        ),
      );

  toPage(Widget page) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page,
      ));
}
