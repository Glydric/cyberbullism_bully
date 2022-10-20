
import 'package:cyberbullism_bully/Model/connect_db/web_socket/user.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const url =
    'ws://8080-glydric22-cyberbullismp-e1b2fmf3noc.ws-eu71.gitpod.io/psyco';

class PsycoWS extends UserWS {
  // TODO! controlla funzionamento
  @override
  final channel = WebSocketChannel.connect(
    Uri.parse(url),
  );

  PsycoWS(User user, String otherEmail) : super(user, otherEmail);
}
