import 'package:flutter/material.dart';

import '/Model/chat/chat.dart';

/// La singola card di una chat
class ChatCard extends StatelessWidget {
  final Chat chat;

  const ChatCard(this.chat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                  Text(chat.getMaxMessage().otherEmail),
                  const Spacer(),
                  Text(chat.getMaxMessage().orario),
                ]),
                const Text(''),
                Text(chat.getMaxMessage().text),
              ]),
            ),
          ),
        ),
      );
}
