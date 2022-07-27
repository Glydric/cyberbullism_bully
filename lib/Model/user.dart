class User {
  final String email;
  final String nome;
  final String cognome;
  final String password;

  User(this.nome, this.cognome, this.password, this.email);

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

  Map<String, dynamic> toJson() => {
        'email': email,
        'nome': nome,
        'cognome': cognome,
        'password': password,
      };
}
