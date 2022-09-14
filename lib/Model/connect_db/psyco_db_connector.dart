import 'dart:convert';

import 'package:intl/intl.dart';

import 'user_db_connector.dart';
import 'package:http/http.dart';

import '../chat/message.dart';
import '../psyco/albo_getter.dart';
import '../psyco/psyco.dart';
import '../segnalazione.dart';
import '../user.dart';
import 'login_exception.dart';

class PsycoDbConnector extends UserDbConnector {
  static psyChecks(User psy) async {
    LoginException.psyThrower(
      await AlboGetter.getFuturePsyco(
        psy.nome,
        psy.cognome,
        "", //TODO implementare l'ordine
        psy.password,
      ),
      psy.email,
      psy.nome,
      psy.cognome,
    );
  }

  static addUser(User user) async {
    await psyChecks(user);
    Response response = await post(
      Uri.parse(url +
          "PsycoCreate.php" +
          "?nome=" +
          user.nome +
          "&cognome=" +
          user.cognome +
          "&email=" +
          user.email +
          "&password=" +
          user.password),
    );
    LoginException.thrower(response.body);
  }

  static Future<Psyco> getUser(String email, String password) async {
    Response response = await post(Uri.parse(
      url +
          "PsycoGet.php" +
          "?email=" +
          email +
          "&password=" +
          User.crypt(password),
    ));
    LoginException.thrower(response.body);
    final json = jsonDecode(response.body);
    return Psyco.fromJson(json);
  }

  static Future<List<Segnalazione>> getSegnalazioni(User user) async {
    Response response = await post(Uri.parse(
      url +
          "PsycoGetSegnalazioni.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password,
    ));
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((s) => Segnalazione.fromJson(s)).toList();
  }

  static Future<List<Message>> getLastMessages(User user) async {
    Response response = await post(
      Uri.parse(url +
          "PsycoGetLastMessages.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password),
    );
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Message.fromJson(json)).toList();
  }

  static Future<List<Message>> getMessagesOf(
      User user, String otherEmail) async {
    Response response = await post(
      Uri.parse(url +
          "PsycoGetMessages.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password +
          "&otherEmail=" +
          otherEmail),
    );
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Message.fromJson(json)).toList();
  }

  static void sendMessage(User user, String otherEmail, String testo) async {
    Response response = await post(
      Uri.parse(url +
          "PsycoSendMessage.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password +
          "&otherEmail=" +
          otherEmail +
          "&testo=" +
          testo),
    );
    LoginException.thrower(response.body);
  }

  static void presaInCarica(
      User user, Segnalazione segnalazione) async {
    Response response = await post(
      Uri.parse(url +
          "PsycoPresaInCarica.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password +
          "&otherEmail=" +
          segnalazione.email +
          "&data=" +
          DateFormat('yyyy-MM-dd hh:mm:ss').format(segnalazione.data)),
    );
    LoginException.thrower(response.body);
  }
}
