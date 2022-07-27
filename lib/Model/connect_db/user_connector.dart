import '/Model/user.dart';

class DbUserConnector {
  static addUser(User user, int firebaseID) {
    throw Exception("Metodo non definito\nuser: " +
        user.toString() +
        "\nfirebaseID:" +
        firebaseID.toString());
  }

  static modifyUserPassword(User user, String newPassword) {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova password: " +
        newPassword);
  }

  static addSegnalazione(User user, String testo, int gravita) {
    throw Exception("Metodo non definito, user" +
        user.toString() +
        "\n nuova segnalazione: " +
        testo +
        "\n gravita: " +
        gravita.toString());
  }

  static newSegnalazione(int userId, String testo) {}
}
