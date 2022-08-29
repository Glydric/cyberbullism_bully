import 'message.dart';

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

  Message getMaxMessage() => messages[messages.length - 1];
}
