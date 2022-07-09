import '/user/user.dart';

class Psyco extends User {
  late final String ordine;
  late final String sezione;
  late final bool isValid;
  late final String pageUrl;

  Psyco(Map<String, dynamic> map)
      : super(map["nome"], map["cognome"], "Password", map["pec"]) {
    ordine = map["ordine"];
    sezione = map["sezione"];
    isValid = map["isValid"];
    pageUrl = map["pageUrl"];
  }


  // ///Getters
  // String getNome() => super.nome;

  // String getCognome() => super.cognome;

  // String getPec() => super.email;

  // String getSezione() => sezione;

  // String getOrdine() => ordine;

  // String isValid() => isValid.toString();
}
