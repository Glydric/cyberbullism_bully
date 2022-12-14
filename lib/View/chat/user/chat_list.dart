import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/chat/chat.dart';
import 'package:cyberbullism_bully/View/chat/chat_card.dart';

import 'chat_view.dart';

class ChatList extends StatefulWidget {
  final List<Chat> chats;
  final User user;

  const ChatList(this.user, this.chats, {Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (_, int _index) => GestureDetector(
          onTap: () => toChatPage(widget.chats[_index].otherEmail),
          child: ChatCard(widget.chats[_index].getMaxMessage()),
        ),
      );

  toChatPage(String otherEmail) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => navigate(otherEmail),
      ));

  navigate(String otherEmail) => ChatView(widget.user, otherEmail);
}
