import '/user/user.dart';

class Psyco extends User {
  late final String ordine;
  late final String sezione;
  late final String isValid;
  late final String pageUrl;

  Psyco(Map<String, dynamic> map)
      : super(map["nome"], 
      map["cognome"],
      "Password",
      map["pec"]) {
    ordine = map["ordine"];
    sezione = map["sezione"];
    isValid = map["isValid"];
    pageUrl = map["pageUrl"];
  }
}
