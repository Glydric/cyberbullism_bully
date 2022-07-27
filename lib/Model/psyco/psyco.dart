import '../user.dart';

class Psyco extends User {
  late final String isValid;

  Psyco(Map<String, dynamic> map)
      : super(map["nome"], map["cognome"], "Password", map["pec"]) {
    isValid = map["isValid"];
  }
}
