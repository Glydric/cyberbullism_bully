import 'dart:convert';

import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cyberbullism_bully/Model/user.dart';

import 'package:cyberbullism_bully/Model/chat/message.dart';

const url = 'wss://echo.websocket.events';

class UserWS {
  final User user;
  final String otherEmail;
  final channel = WebSocketChannel.connect(
    Uri.parse(url),
  );

  UserWS(this.user, this.otherEmail);

  Future<List<Message>> get messages async {
    final jsonValue = await channel.stream.last;

    LoginException.thrower(jsonValue);
    
    final List<dynamic> jsonList = jsonDecode(jsonValue);

    return jsonList.map((json) => Message.fromJson(json)).toList();
  }
}
