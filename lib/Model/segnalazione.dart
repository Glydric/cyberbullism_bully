class Segnalazione {
  String email;
  String testo;
  String orario;
  int gravita;

  Segnalazione(this.testo, this.orario, this.gravita, this.email);
  Segnalazione.fromJson(json)
      : email = json["email"],
        testo = json["testo"],
        orario = json["orario"],
        gravita = json["gravita"];
}
