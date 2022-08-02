import 'dart:convert';

import 'package:http/http.dart';

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
    return User.fromJson(jsonDecode(response.body));
  }

  static modifyPassword(User user, String newPassword) {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova password: " +
        newPassword);
  }

  static addSegnalazione(User user, String testo, int gravita) {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova segnalazione: " +
        testo +
        "\n gravita: " +
        gravita.toString());
  }

  static newSegnalazione(String userEmail, String testo) {}

  static newSegnalazioneFromUser(User user, String testo) =>
      newSegnalazione(user.email, testo);
}
