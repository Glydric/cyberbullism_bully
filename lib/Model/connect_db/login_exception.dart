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
}
