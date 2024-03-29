import 'dart:convert';

import 'package:http/http.dart';

import 'package:cyberbullism_bully/Model/chat/message.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/connect_db/login_exception.dart';

const url = "https://8000-glydric22-cyberbullismb-zws4lqicytd.ws-eu79.gitpod.io/";

const String userFile = "User";

class UserDbConnector {
  /// consente di creare l'utente sul database
  static addUser(User user) async {
    final body = {
      "nome": user.nome,
      "cognome": user.cognome,
      "email": user.email,
      "password": user.password,
    };
    Response response = await post(
      Uri.parse(url + userFile + "Create.php"),
      body: body,
    );
    LoginException.thrower(response.body);
  }

  /// consente di ottenere l'utente da email e password
  static Future<User> getUser(String email, String password) async {
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
    return User.fromJson(json);
  }

  /// consente di modificare la password del'utente passando la nuova
  static modifyPassword(
      User user, String insertedPassword, String newPassword) async {
    final body = {
      "email": user.email,
      "password": user.password,
      "newPassword": User.crypt(user.email, newPassword),
    };
    // se la password attuale è diversa da quella fornita (e criptata)
    if (user.password != User.crypt(user.email, insertedPassword)) {
      throw LoginException('wrong-password');
    }
    Response response = await post(
      Uri.parse(url + userFile + "ChangePassword.php"),
      body: body,
    );
    LoginException.thrower(response.body);
  }

  /// Consente di aggiungere una segnalazione al database passando un utente
  /// Richiama addSegnalazione prendendo l'email dall'utente passato
  static Future<bool> addSegnalazioneFromUser(
    User user,
    String testo,
    int gravita,
  ) async {
    return addSegnalazione(user.email, user.password, testo, gravita);
  }

  /// Consente di aggiungere una segnalazione al database passando direttamente l'email
  static Future<bool> addSegnalazione(
    String userEmail,
    String password,
    String testo,
    int gravita,
  ) async {
    final body = {
      "email": userEmail,
      "password": password,
      "testo": testo,
      "gravita": gravita.toString(),
    };
    try {
      await post(
        Uri.parse(url + userFile + "CreateSegnalazione.php"),
        body: body,
      );
      return true;
    } catch (_) {
      return false;
    }
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
}
