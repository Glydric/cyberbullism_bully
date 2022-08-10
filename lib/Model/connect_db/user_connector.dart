import 'dart:convert';

import 'package:http/http.dart';

import '/Model/psyco/psyco.dart';
import '/Model/user.dart';
import '/Model/connect_db/login_exception.dart';

const url = "http://leonardomigliorelli.altervista.org/";

class DbUserConnector {
  /// consente di creare l'utente sul database
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

  /// consente di ottenere l'utente da email e password
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

  /// consente di modificare la password del'utente passando la nuova
  static modifyPassword(User user, String newPassword) async {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova password: " +
        newPassword);/* 
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
    LoginException.thrower(response.body); */
    //TODO aggiungere la modifica della password
  }

  /// Consente di aggiungere una segnalazione al database passando un utente
  /// Richiama addSegnalazione prendendo l'email dall'utente passato
  static addSegnalazioneFromUser(User user, String testo) async {
    addSegnalazione(user.email, testo);
  }

  /// Consente di aggiungere una segnalazione al database passando direttamente l'email
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

  /// consente di ottenere la gravità passando un testo
  static int getGravitaFrom(String testo) {
    //TODO Implementare l'algoritmo per derivare la gravita
    return 0;
  }
}
