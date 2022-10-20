import 'package:flutter/material.dart';

import '../chat_card.dart';
import '/Model/user.dart';
import '/Model/chat/chat.dart';

import 'chat_view.dart';

class PsycoChatList extends StatefulWidget {
  final List<Chat> chats;
  final User user;

  const PsycoChatList(this.user, this.chats, {Key? key}) : super(key: key);

  @override
  State<PsycoChatList> createState() => _PsycoChatListState();
}

class _PsycoChatListState extends State<PsycoChatList> {
  //Can't extend ChatListState because context not working anymore
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (_, int _index) => GestureDetector(
          onTap: () => toChatPage(widget.chats[_index].otherEmail),
          child: ChatCard(widget.chats[_index].getMaxMessage()),
        ),
      );

  toChatPage(String otherEmail) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PsycoChatView(widget.user, otherEmail),
      )); 
}
