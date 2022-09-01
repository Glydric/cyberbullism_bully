import 'package:flutter/material.dart';

import '/Model/chat/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {Key? key}) : super(key: key);

  get cardColor => const Color.fromARGB(255, 233, 233, 233);

  get messageAlignment =>
      message.sender ? Alignment.centerLeft : Alignment.centerRight;

  get marginAlignments => EdgeInsets.only(
        left: message.sender ? 0 : 50,
        right: message.sender ? 50 : 0,
      );

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(
          "\n" + message.orario + "\n",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 10),
        ),
        Align(
          alignment: messageAlignment,
          child: Card(
            margin: marginAlignments,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: cardColor,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        )
      ]);
}
