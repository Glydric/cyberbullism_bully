import 'package:intl/intl.dart';

class Segnalazione {
  String email;
  String testo;
  int gravita;
  DateTime data;

  Segnalazione(this.testo, this.data, this.gravita, this.email);

  Segnalazione.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        testo = json["testo"],
        data = DateTime.parse(json["data"]),
        gravita = int.parse(json["gravita"]);

  String get yearMonth => DateFormat.yMd().format(data);
  String get hourDay => DateFormat.Hm().format(data);
}
