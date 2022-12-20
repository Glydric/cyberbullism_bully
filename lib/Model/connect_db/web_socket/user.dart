import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cyberbullism_bully/Model/user.dart';

const url = 'ws://8080-glydric22-cyberbullismb-zws4lqicytd.ws-eu79.gitpod.io/';

//* update url on necessity
class UserWS {
  final channel = WebSocketChannel.connect(
    Uri.parse(url + 'User'),
  );

  UserWS(User user, String otherEmail) {
    channel.sink.add("set " +
        jsonEncode({
          'email': user.email,
          'password': user.password,
          'otherEmail': otherEmail,
        }));
  }

  Stream<dynamic> get stream => channel.stream;

  void sendMessage(String message) => channel.sink.add("send " + message);

  void close() => channel.sink.close();
}
