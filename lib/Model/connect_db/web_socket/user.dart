import 'dart:async';
import 'dart:convert';

import 'package:cyberbullism_bully/Model/chat/chat.dart';
import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/chat/message.dart';

const url =
    'ws://8080-glydric22-cyberbullismp-e1b2fmf3noc.ws-eu71.gitpod.io/user';

class UserWS {
  final channel = WebSocketChannel.connect(
    Uri.parse(url),
  );

  UserWS(User user, String otherEmail) {
    channel.sink.add("set " +
        jsonEncode({
          'email': user.email,
          'password': user.password,
          'otherEmail': otherEmail,
        }));
    update();
  }

  Stream<dynamic> get stream => channel.stream;

  void update() => channel.sink.add("reload");

  void sendMessage(String message) => channel.sink.add("send " + message);

  void close() => channel.sink.close();

  Future<Chat> get messages async {
    final body = await channel.stream.last;
    
    LoginException.thrower(body);

    final List<dynamic> jsonList = jsonDecode(body);
    final messages= jsonList.map((json) => Message.fromJson(json)).toList();
    return Chat.fromList(messages);
  }
}
