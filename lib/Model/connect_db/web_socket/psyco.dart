import 'package:cyberbullism_bully/Model/connect_db/web_socket/user.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PsycoWS extends UserWS {
  @override
  // ignore: overridden_fields
  final channel = WebSocketChannel.connect(
    Uri.parse(url + 'Psyco'),
  );

  PsycoWS(User user, String otherEmail) : super(user, otherEmail);
}
