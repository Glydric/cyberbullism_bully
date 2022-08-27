import 'message.dart';

/// Una lista di messaggi con lo stesso psicologo
class Chat {
  final List<Message> messages;
  final String otherEmail;

  Chat()
      : messages = <Message>[],
        otherEmail = "";
  
  addMessage(Message message){
    messages.add(message);
  }

  Message getMaxMessage() => messages[messages.length - 1];
}
