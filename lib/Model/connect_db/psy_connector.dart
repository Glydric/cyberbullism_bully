import 'dart:convert';

import 'package:http/http.dart';

import '../segnalazione.dart';
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

  static Future<List<Segnalazione>> getSegnalazioni() async {
    Response response = await post(Uri.parse(url + "getSegnalazioni.php"));
    final List<dynamic> jsonList = jsonDecode(response.body);
    final List<Segnalazione> result = <Segnalazione>[];

    for (var json in jsonList) {
      result.add(Segnalazione.fromJson(jsonEncode(json)));
    }

    return result;
  }
}
