import 'message.dart';

/// Una lista di messaggi con lo stesso psicologo
class Chat {
  final List<Message> messages;
  
  Chat() : messages = <Message>[];

  Chat.fromList(String userEmail, List<Message> messageList)
      : messages = messageList
            .where((message) => message.otherEmail == userEmail)
            .toList();
}
