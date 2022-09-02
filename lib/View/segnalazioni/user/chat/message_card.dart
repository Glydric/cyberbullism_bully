import 'package:flutter/material.dart';

import '/Model/chat/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {Key? key}) : super(key: key);

  Color get cardColor => const Color.fromARGB(255, 233, 233, 233);

  Alignment get messageAlignment =>
      message.sender ? Alignment.centerLeft : Alignment.centerRight;

  CrossAxisAlignment get crossTextAlignment =>
      message.sender ? CrossAxisAlignment.start : CrossAxisAlignment.end;

  // TextAlign get textAlignment =>
  //     message.sender ? TextAlign.left : TextAlign.right;

  EdgeInsets get marginAlignments => EdgeInsets.only(
        left: message.sender ? 0 : 50,
        right: message.sender ? 50 : 0,
      );

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(
          "\n" + message.yearMonthDate + "\n",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 10),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: messageAlignment,
            child: Card(
              margin: marginAlignments,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: cardColor,
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                child: Column(
                  crossAxisAlignment: crossTextAlignment,
                  children: [
                    Text(
                      message.text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      message.hourMinutes,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]);
}
