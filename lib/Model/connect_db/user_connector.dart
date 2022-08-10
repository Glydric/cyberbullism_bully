import 'dart:convert';

import 'package:http/http.dart';

import '/Model/psyco/psyco.dart';
import '/Model/user.dart';
import '/Model/connect_db/login_exception.dart';

const url = "http://leonardomigliorelli.altervista.org/";

class DbUserConnector {
  static addUser(User user) async {
    Response response = await post(
      Uri.parse(
        url +
            "createUser.php" +
            "?nome=" +
            user.nome +
            "&cognome=" +
            user.cognome +
            "&email=" +
            user.email +
            "&password=" +
            user.password,
      ),
    );
    LoginException.thrower(response.body);
  }

  static Future<User> getUser(String email, String password) async {
    Response response = await post(
      Uri.parse(url +
          "getUser.php" +
          "?email=" +
          email +
          "&password=" +
          User.crypt(password)),
    );
    LoginException.thrower(response.body);
    final json = jsonDecode(response.body);
    return json["isPsy"] == 0 ? User.fromJson(json) : Psyco.fromJson(json);
  }

  static modifyPassword(User user, String newPassword) async {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova password: " +
        newPassword);
    Response response = await post(
      Uri.parse(
        url +
            "getUser.php" +
            "?email=" +
            user.email +
            "&password=" +
            user.password +
            "&newPassword=" +
            newPassword,
      ),
    );
    LoginException.thrower(response.body);
    //TODO completare
  }

  static addSegnalazioneFromUser(User user, String testo) async {
    addSegnalazione(user.email, testo);
  }

  static addSegnalazione(String userEmail, String testo) async {
    Response response = await post(
      Uri.parse(
        url +
            "createUser.php" +
            "?email=" +
            userEmail +
            "&testo=" +
            testo +
            "&gravita=" +
            getGravitaFrom(testo).toString(),
      ),
    );
  }

  static int getGravitaFrom(String testo) {
    //TODO Implementa gravita
    return 0;
  }
}
