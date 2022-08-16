import 'dart:convert';
import 'package:crypto/crypto.dart';

class User {
  final String email;
  final String nome;
  final String cognome;
  final String password;

  static String crypt(String password) =>
      sha256.convert(utf8.encode(password)).toString();

  User(this.nome, this.cognome, this.email, password)
      : password = crypt(password);

  User.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        nome = json["nome"],
        cognome = json["cognome"],
        password = json["password"];

  Map<String, String> toJson() => {
        'type': "User",
        'email': email,
        'nome': nome,
        'cognome': cognome,
        'password': password,
      };

  @override
  String toString() =>
      "nome: " +
      nome +
      "\ncognome: " +
      cognome +
      "\npassword:" +
      password +
      "\nemail: " +
      email;
}
