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
    final body = {
      "nome": user.nome,
      "cognome": user.cognome,
      "email": user.email,
      "password": user.password,
      "Auth_Key_Create_Psyco": "24BEC3BFA"
    };
    Response response = await post(
      Uri.parse(url + userFile + "Create.php"),
      body: body,
    );
    LoginException.thrower(response.body);
  }

  static Future<Psyco> getUser(String email, String password) async {
    final body = {
      "email": email,
      "password": User.crypt(email, password),
    };
    Response response = await post(
      Uri.parse(url + userFile + "Get.php"),
      body: body,
    );
    LoginException.thrower(response.body);
    final json = jsonDecode(response.body);
    return Psyco.fromJson(json);
  }

  static Future<List<Segnalazione>> getSegnalazioni(User user) async {
    final body = {
      "email": user.email,
      "password": user.password,
    };
    Response response = await post(
      Uri.parse(url + userFile + "GetSegnalazioni.php"),
      body: body,
    );
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((s) => Segnalazione.fromJson(s)).toList();
  }

  static Future<List<Message>> getLastMessages(User user) async {
    final body = {
      "email": user.email,
      "password": user.password,
    };

    Response response = await post(
      Uri.parse(url + userFile + "GetLastMessages.php"),
      body: body,
    );
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Message.fromJson(json)).toList();
  }

  static void presaInCarica(User user, Segnalazione segnalazione) async {
    final body = {
      "email": user.email,
      "password": user.password,
      "otherEmail": segnalazione.email,
      "data": DateFormat('yyyy-MM-dd HH:mm:ss').format(segnalazione.data),
    };
    Response response = await post(
      Uri.parse(url + userFile + "PresaInCarica.php"),
      body: body,
    );
    LoginException.thrower(response.body);
  }
}
