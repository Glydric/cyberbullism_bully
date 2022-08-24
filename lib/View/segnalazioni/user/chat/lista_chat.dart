import 'package:flutter/material.dart';

import 'chat_card.dart';

class ListaChat extends StatefulWidget {
  final List<ChatCard> chats;

  const ListaChat(this.chats, {Key? key}) : super(key: key);

  @override
  State<ListaChat> createState() => _ListaChatState();
}

class _ListaChatState extends State<ListaChat> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    child: ListView.builder(
          itemCount: widget.chats.length,
          itemBuilder: (_, int _index) => widget.chats[_index],
        ),
  );
}
