import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart';

import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';
import 'package:cyberbullism_bully/Model/chat/message.dart';
import 'package:cyberbullism_bully/Model/psyco/albo_getter.dart';
import 'package:cyberbullism_bully/Model/psyco/psyco.dart';
import 'package:cyberbullism_bully/Model/segnalazione.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';

const String userFile = "Psyco";

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
      Uri.parse(
        url +
            userFile +
            "Create.php" +
            "?nome=" +
            user.nome +
            "&cognome=" +
            user.cognome +
            "&email=" +
            user.email +
            "&password=" +
            user.password +
            "&Auth_Key_Create_Psyco=24BEC3BFA",
      ),
    );
    LoginException.thrower(response.body);
  }

  static Future<Psyco> getUser(String email, String password) async {
    Response response = await post(Uri.parse(
      url +
          userFile +
          "Get.php" +
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
          userFile +
          "GetSegnalazioni.php" +
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
          userFile +
          "GetLastMessages.php" +
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
          userFile +
          "GetMessages.php" +
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
          userFile +
          "SendMessage.php" +
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

  static void presaInCarica(User user, Segnalazione segnalazione) async {
    Response response = await post(
      Uri.parse(url +
          userFile +
          "PresaInCarica.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password +
          "&otherEmail=" +
          segnalazione.email +
          "&data=" +
          DateFormat('yyyy-MM-dd HH:mm:ss').format(segnalazione.data)),
    );
    LoginException.thrower(response.body);
  }
}
