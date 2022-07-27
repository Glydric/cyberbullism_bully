import '../user.dart';

class Psyco extends User {
  final String isValid;

  /// costruttore per lo psicologo, utilizzato per la costruzione dall'albo
  Psyco.fromAlbo(Map<String, dynamic> map, String password)
      : isValid = map["isValid"],
        super(
          map["nome"],
          map["cognome"],
          map["email"],
          password,
        );

  Psyco.fromJson(Map<String, dynamic> json)
      : isValid = json["isValid"],
        super.fromJson(json);
}