import 'package:intl/intl.dart';

class Segnalazione {
  final String email;
  final String nome;
  final String cognome;
  final String testo;
  final int gravita;
  final DateTime data;

  Segnalazione(
      this.testo, this.data, this.gravita, this.email, this.cognome, this.nome);

  Segnalazione.fromJson(Map<String, dynamic> json)
      : email = json["user_email"],
        testo = json["testo"],
        nome = json["nome"],
        cognome = json["cognome"],
        data = DateTime.parse(json["data"]),
        gravita = int.parse(json["gravita"]);

  String get yearMonth => DateFormat.yMd().format(data);
  String get hourDay => DateFormat.Hm().format(data);

  String get nomeCognome => nome + " " + cognome;
}
