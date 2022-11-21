import 'dart:convert';
import 'package:cyberbullism_bully/Model/chat/message.dart';

/// Una lista di messaggi con lo stesso psicologo
class Chat {
  final List<Message> messages;
  final String otherEmail;

  Chat()
      : messages = <Message>[],
        otherEmail = "";

  Chat.singleMessage(Message message)
      : messages = <Message>[message],
        otherEmail = message.otherEmail;

  Chat.fromList(List<Message> messageList)
      : otherEmail = messageList[0].otherEmail,
        messages = messageList
            .where((message) => message.otherEmail == messageList[0].otherEmail)
            .toList();

  factory Chat.fromJsonString(String body) {
    final List<dynamic> jsonList = jsonDecode(body);
    final messages = jsonList.map((json) => Message.fromJson(json)).toList();
    return Chat.fromList(messages);
  }
  Message getMaxMessage() => messages[messages.length - 1];
}
