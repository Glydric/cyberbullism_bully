class Message {
  final String otherEmail;
  final String text;
  final String orario;

  Message(this.otherEmail, this.text, this.orario);

  Message.fromJson(Map<String, dynamic> json)
      : otherEmail = json["email"],
        text = json["text"],
        orario = json["orario"];
}
