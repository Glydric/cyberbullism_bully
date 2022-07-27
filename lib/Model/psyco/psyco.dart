import '../user.dart';

class Psyco extends User {
  final String isValid;

  Psyco(Map<String, dynamic> map, String password)
      : isValid = map["isValid"],
        super(map["nome"], map["cognome"], password, map["email"]);

  Psyco.fromJson(Map<String, dynamic> json)
      : isValid = json["isValid"],
        super(json["nome"], json["cognome"], json["Password"], json["email"]);
}
