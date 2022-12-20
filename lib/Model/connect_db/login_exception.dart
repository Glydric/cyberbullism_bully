class LoginException implements Exception {
  final dynamic message;
  static final Map<String, String> errorCodes = {
    "user-not-found": "Utente o password errata",
    "invalid-email": "Inserire un'email corretta",
    "email-already-in-use": "Account già esistente",
    "empty-password": "Inserire una password",
    "wrong-password": "Password Sbagliata",
    "weak-password": "La password non è sicura",
    "pec-invalid": "Pec psicologo non valida",
    "psyco-invalid": "Psicologo non iscritto all'albo",
    "too-many-requests": "Troppi tentativi, provare più tardi",
  };

  LoginException(this.message);

  @override
  toString() => errorCodes[message] ?? "Errore Sconosciuto" + message;

  ///passando una stringa solleva l'eccezione se essa è presente
  static void thrower(String textCode) {
    if (errorCodes.containsKey(textCode)) {
      throw LoginException(textCode);
    }
  }
}
