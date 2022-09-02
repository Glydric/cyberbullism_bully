import 'package:intl/intl.dart';

class Message {
  final String otherEmail;
  final String text;
  final DateTime data;
  final bool sender;
  final f = DateFormat('yyyy-MM-dd hh:mm');

  Message(this.otherEmail, this.text, this.data, this.sender);

  Message.fromJson(Map<String, dynamic> json)
      : otherEmail = json["otherEmail"],
        text = json["testo"],
        data = DateTime.parse(json["data"]),
        sender = json["sender"] == "1";

  String get hourMinutes => data.hour.toString() + ":" + data.minute.toString();

  String get yearMonthDate => DateFormat.yMMMd().format(data);

  String get dayMonth =>
      data.timeZoneName +
      "/" +
      data.month.toString() +
      "/" +
      data.day.toString();
}
