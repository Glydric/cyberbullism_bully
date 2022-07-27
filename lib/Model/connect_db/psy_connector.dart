import '/Model/psyco/psyco.dart';

const url = "miglio.tech";

class DbPsyConnector {
  static addPsy(Psyco psi, int firebaseID) {
    throw Exception("Metodo non definito\npsicologo: " +
        psi.toString() +
        "\nfirebaseID:" +
        firebaseID.toString());
  }

  static modifyPsyPassword(Psyco psi, String newPassword) {
    throw Exception("Metodo non definito\nuser: " +
        psi.toString() +
        "\n nuova password: " +
        newPassword);
  }

  static String getSegnalazioni() {
    
    return '';
  }
}
