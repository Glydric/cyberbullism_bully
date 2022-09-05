import 'package:intl/intl.dart';

class Message {
  final String otherEmail;
  final String text;
  final bool sender;
  final DateTime data;

  Message(this.otherEmail, this.text, this.data, this.sender);

  Message.fromJson(Map<String, dynamic> json)
      : otherEmail = json["otherEmail"],
        text = json["testo"],
        data = DateTime.parse(json["data"]),
        sender = json["sender"] == "1";

  String get hourMinutes => DateFormat.Hm().format(data);

  String get yearMonthDate => DateFormat.yMMMd().format(data);
}
