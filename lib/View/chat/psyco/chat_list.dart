import 'package:cyberbullism_bully/View/chat/user/chat_list.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

class PsycoChatList extends ChatList {
  const PsycoChatList(user, chats, {Key? key}) : super(user, chats, key: key);

  @override
  State<ChatList> createState() => _PsycoChatListState();
}

class _PsycoChatListState extends ChatListState {
  @override
  navigate(String otherEmail) => PsycoChatView(widget.user, otherEmail);
}
