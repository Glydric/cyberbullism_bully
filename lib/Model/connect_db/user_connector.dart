import 'package:http/http.dart';

import '/Model/user.dart';

const url = "http://leonardomigliorelli.altervista.org/";

class DbUserConnector {
  static addUser(User user) => post(
        Uri.parse(
          url +
              "createUser.php?" +
              "nome=" +
              user.nome +
              "&cognome=" +
              user.cognome +
              "&email=" +
              user.email +
              "&password=" +
              user.password,
        ),
      );

  static Future<User> getUser(String email, String password) async {
    throw Exception(
        "Metodo non definito\nuser: " + email + " password" + password);
  }

  static modifyUserPassword(User user, String newPassword) {
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
