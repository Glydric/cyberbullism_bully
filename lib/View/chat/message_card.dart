import 'package:flutter/material.dart';
import 'package:cyberbullism_bully/Model/chat/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final bool showDate;
  final bool isLast;

  const MessageCard(
    this.message, {
    Key? key,
    this.showDate = true,
    this.isLast = false,
  }) : super(key: key);

  Color get cardColor => const Color.fromARGB(255, 233, 233, 233);

  Color? get gravityColor {
    switch (message.gravita) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      case null:
        return null;
      default:
        throw Exception(
          "Errore nella visualizzazione della gravità \n gravità = " +
              message.gravita.toString(),
        );
    }
  }

  Alignment get messageAlignment =>
      message.sender ? Alignment.centerLeft : Alignment.centerRight;

  CrossAxisAlignment get crossTextAlignment =>
      message.sender ? CrossAxisAlignment.start : CrossAxisAlignment.end;

  EdgeInsets get marginAlignments => EdgeInsets.only(
        left: message.sender ? 0 : 50,
        right: message.sender ? 50 : 0,
      );

  EdgeInsets get lastPadding =>
      const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(
        bottom: isLast ? 16 : 0,
      );

  @override
  Widget build(BuildContext context) => Column(children: [
        Visibility(
          visible: showDate,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Chip(
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
              label: Text(message.yearMonthDate),
            ),
          ),
        ),
        Padding(
          padding: lastPadding,
          child: Align(
            alignment: messageAlignment,
            child: Column(
              crossAxisAlignment: crossTextAlignment,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    message.hourMinutes,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Card(
                  shadowColor: gravityColor,
                  margin: marginAlignments,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      message.text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]);
}
