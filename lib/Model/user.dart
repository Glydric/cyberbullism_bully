import 'package:dbcrypt/dbcrypt.dart';

const salt = r'$2b$10$9ic4zJ8DFwSdl83iq09Io.';

class User {
  final String email;
  final String nome;
  final String cognome;
  final String password;

  User(this.nome, this.cognome, this.email, password)
      : password = crypt(email, password);

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

  static String _hash(String text) =>
      // sha256.convert(utf8.encode(text)).toString();
      DBCrypt().hashpw(text, salt);

  // using bcrypt like hashing method
  static String crypt(String email, String password) =>
      _hash(_hash(email) + salt + _hash(password));

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
