import '../psyco/psyco.dart';

class LoginException implements Exception {
  final dynamic message;
  static final List<String> errorCodes = [
    "invalid-email",
    "user-not-found",
    "too-many-requests",
    "empty-password",
    "wrong-password"
  ];

  LoginException(this.message);
  @override
  toString() => message;

  ///passando una stringa solleva l'eccezione se essa è presente
  static void thrower(String textCode) {
    if (errorCodes.contains(textCode)) {
      throw LoginException(textCode);
    }
  }

  ///passando una stringa solleva eccezioni tipiche degli psicologi se essa è presente
  static void psyThrower(Psyco psy, String email, String nome, String cognome) {
    if (email != psy.email) {
      throw LoginException("pec-invalid");
    }
    if (psy.isValid != "true") {
      throw LoginException("psy-invalid");
    }
    if (nome.toLowerCase() != psy.nome.toLowerCase() ||
        cognome.toLowerCase() != psy.cognome.toLowerCase()) {
      throw LoginException("psy-not-found");
    }
  }
}
