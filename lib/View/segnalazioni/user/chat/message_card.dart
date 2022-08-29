import 'package:flutter/material.dart';

import '/Model/chat/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            "\n" + message.orario + "\n",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          ),
          Align(
            alignment:
                message.sender ? Alignment.centerLeft : Alignment.centerRight,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message.text),
              ),
            ),
          )
        ],
      );
}
