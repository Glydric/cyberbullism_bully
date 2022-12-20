
class LoginException implements Exception {
  final dynamic message;
  static final List<String> errorCodes = [
    "user-not-found",
    "invalid-email",
    "email-already-in-use",
    "empty-password",
    "wrong-password"
        "too-many-requests",
  ];

  LoginException(this.message);

  @override
  toString() {
    switch (message) {
      case "invalid-email":
        return "Inserire un'email corretta";
      case "email-already-in-use":
        return "Account già esistente";
      case "weak-password":
        return "La password non è sicura";
      case 'wrong-password':
        return "Password Sbagliata";
      case "pec-invalid":
        return "Pec psicologo non valida";
      case "psyco-invalid":
        return "Psicologo sospeso dalla carica";
      case "psyco-not-found":
        return "Psicologo non iscritto all'albo";
      case "user-not-found":
        return "Utente o password errata";
      case "too-many-requests":
        return "Troppi tentativi, provare più tardi";
      default:
        return 'Errore Sconosciuto';
    }
  }

  ///passando una stringa solleva l'eccezione se essa è presente
  static void thrower(String textCode) {
    if (errorCodes.contains(textCode)) {
      throw LoginException(textCode);
    }
  }
}
