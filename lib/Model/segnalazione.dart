import 'package:intl/intl.dart';

class Segnalazione {
  String email;
  String nome;
  String cognome;
  String testo;
  int gravita;
  DateTime data;

  Segnalazione(
      this.testo, this.data, this.gravita, this.email, this.cognome, this.nome);

  Segnalazione.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        testo = json["testo"],
        nome = json["nome"],
        cognome = json["cognome"],
        data = DateTime.parse(json["data"]),
        gravita = int.parse(json["gravita"]);

  String get yearMonth => DateFormat.yMd().format(data);
  String get hourDay => DateFormat.Hm().format(data);
}
