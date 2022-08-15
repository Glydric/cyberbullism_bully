class LoginException implements Exception {
  final dynamic message;

  LoginException(this.message);
  @override
  toString() => message;

  ///passando una stringa solleva l'eccezione se essa è presente
  static void thrower(String body) {
    switch (body) {
      case "invalid-email":
        throw LoginException("invalid-email");
      case "user-not-found":
        throw LoginException("user-not-found");
      case "too-many-requests":
        throw LoginException("too-many-requests");
      case "empty-password":
        throw LoginException("empty-password");
    }
  }
}