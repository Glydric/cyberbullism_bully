import 'package:intl/intl.dart';

class Message {
  final String otherEmail;
  final String nome;
  final String cognome;
  final String testo;
  final DateTime data;
  final bool sendByUser;
  final int? gravita;

  Message(
    this.otherEmail,
    this.nome,
    this.cognome,
    this.testo,
    this.data,
    this.sendByUser,
    this.gravita,
  );

  Message.fromJson(Map<String, dynamic> json)
      : otherEmail = json["otherEmail"],
        testo = json["testo"],
        nome = json["nome"],
        cognome = json["cognome"],
        data = DateTime.parse(json["data"]),
        sendByUser = json["send_by_user"] == "1",
        gravita = json["gravita"] == null ? null : int.parse(json["gravita"]);

  String get nomeCognome => nome + " " + cognome;

  String get hourMinutes => DateFormat.Hm().format(data);

  String get yearMonthDate => DateFormat.yMMMd().format(data);
}
