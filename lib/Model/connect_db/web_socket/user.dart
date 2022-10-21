import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cyberbullism_bully/Model/user.dart';

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
}
