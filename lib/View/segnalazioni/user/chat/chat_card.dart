import 'package:flutter/material.dart';

import '/Model/chat/message.dart';

/// La singola card di una chat
class ChatCard extends StatelessWidget {
  final Message showingMessage;

  const ChatCard(this.showingMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(
                  showingMessage.otherEmail,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(showingMessage.orario.substring(10)),
              ]),
              const Text(''),
              Text((showingMessage.sender ? "" : "Tu: ") + showingMessage.text,
                  maxLines: 3, textAlign: TextAlign.left),
            ]),
          ),
        ),
      );
}
