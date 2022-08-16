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

  ///genera uno psicologo a partire da un json, se isValid non è presente
  ///lo definisce true di default
  Psyco.fromJson(Map<String, dynamic> json) //? TODO serve davvero?
      : isValid = json.containsKey("isValid") ? json["isValid"] : "true",
        super.fromJson(json);

  @override
  Map<String, String> toJson() => {
        'type': "Psyco",
        'email': email,
        'nome': nome,
        'cognome': cognome,
        'password': password,
        'isValid': isValid,
      };
}
