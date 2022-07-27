class User {
  final String nome;
  final String cognome;
  final String password;
  final String email;

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
}
