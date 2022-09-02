class Segnalazione {
  String email;
  String testo;
  String data;
  int gravita;

  Segnalazione(this.testo, this.data, this.gravita, this.email);
  
  Segnalazione.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        testo = json["testo"],
        data = json["data"],
        gravita = int.parse(json["gravita"]);
}
