import 'package:flutter/material.dart';

import '/Model/chat/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {Key? key}) : super(key: key);

  get chipColor => const Color.fromARGB(16, 0, 0, 0);
  get messageAlignment =>
      message.sender ? Alignment.centerLeft : Alignment.centerRight;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            "\n" + message.orario + "\n",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          ),
          Align(
            alignment: messageAlignment,
            child: Chip(
              backgroundColor: chipColor,
              elevation: 4,
              label: Text(message.text),
            ),
          )
        ],
      );
}
