class User {
  final String email;
  final String nome;
  final String cognome;
  final String password;

  User(this.nome, this.cognome, this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        nome = json["nome"],
        cognome = json["cognome"],
        password = json["password"];

  Map<String, String> toJson() => {
        'type': runtimeType.toString(),
        'email': email,
        'nome': nome,
        'cognome': cognome,
        'password': password,
      };

  @override
  String toString() =>
      "nome: " +
      nome +
      "\ncognome: " +
      cognome +
      "\npassword:" +
      password +
      "\nemail: " +
      email;
}
