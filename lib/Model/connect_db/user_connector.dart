import '/Model/user.dart';

const url = "miglio.tech";

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

  static newSegnalazione(String userId, String testo) {}

  static newSegnalazioneFromUser(User user, String testo) =>
      newSegnalazione(user.email, testo);
}
