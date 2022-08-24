import 'dart:convert';

import 'package:http/http.dart';

import '../chat/message.dart';
import '/Model/user.dart';
import '/Model/connect_db/login_exception.dart';

const url = "http://leonardomigliorelli.altervista.org/";

class UserDbConnector {

  /// consente di creare l'utente sul database
  static addUser(User user) async {
    Response response = await post(
      Uri.parse(
        url +
            "UserCreate.php" +
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
          "UserGet.php" +
          "?email=" +
          email +
          "&password=" +
          User.crypt(password)),
    );
    LoginException.thrower(response.body);
    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  /// consente di modificare la password del'utente passando la nuova
  static modifyPassword(User user, String password, String newPassword) async {
    if (user.password != User.crypt(password)) {
      throw LoginException('wrong-password');
    }
    Response response = await post(
      Uri.parse(
        url +
            "UserChangePassword.php" +
            "?email=" +
            user.email +
            "&password=" +
            user.password +
            "&newPassword=" +
            User.crypt(newPassword),
      ),
    );
    LoginException.thrower(response.body);
  }

  /// Consente di aggiungere una segnalazione al database passando un utente
  /// Richiama addSegnalazione prendendo l'email dall'utente passato
  static addSegnalazioneFromUser(User user, String testo) async {
    addSegnalazione(user.email, user.password, testo);
  }

  /// Consente di aggiungere una segnalazione al database passando direttamente l'email
  static addSegnalazione(
      String userEmail, String password, String testo) async {
    Response response = await post(
      Uri.parse(
        url +
            "UserCreateSegnalazione.php" +
            "?email=" +
            userEmail +
            "?password=" +
            password +
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

  static Future<List<Message>> getMessagesOf(User user) async {
    Response response = await post(
      Uri.parse(url +
          "UserGetMessages.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password),
    );
    LoginException.thrower(response.body);
    final List<dynamic> jsonList = jsonDecode(response.body);
    final List<Message> result = <Message>[];

    for (Map<String, dynamic> json in jsonList) {
      result.add(Message.fromJson(json));
    }

    return result;
  }
}
