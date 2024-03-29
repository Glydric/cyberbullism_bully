import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/chat/message.dart';

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
                  showingMessage.nomeCognome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(showingMessage.hourMinutes),
              ]),
              const Text(''),
              Text(
                  (showingMessage.sendByUser ? "" : "Tu: ") +
                      showingMessage.testo,
                  maxLines: 3,
                  textAlign: TextAlign.left),
            ]),
          ),
        ),
      );
}
