class LoginException implements Exception {
  final dynamic message;

  LoginException(this.message);
  @override
  toString() => message;

  ///passando una stringa solleva l'eccezione se essa è presente
  static void thrower(String body) {
    switch (body) {
      case "invalid-email":
      case "user-not-found":
      case "too-many-requests":
      case "empty-password":
      case "wrong-password":
        throw LoginException(body);
    }
  }
}