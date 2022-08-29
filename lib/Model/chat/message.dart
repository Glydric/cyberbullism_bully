class Message {
  final String otherEmail;
  final String text;
  final String orario;
  final bool sender;

  Message(this.otherEmail, this.text, this.orario, this.sender);

  Message.fromJson(Map<String, dynamic> json)
      : otherEmail = json["otherEmail"],
        text = json["testo"],
        orario = json["orario"],
        sender = json["sender"] == "1";
}
