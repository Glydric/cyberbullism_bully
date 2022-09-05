import 'dart:convert';

import 'package:cyberbullism_bully/Model/connect_db/user_db_connector.dart';
import 'package:http/http.dart';

import '../psyco/albo_getter.dart';
import '../psyco/psyco.dart';
import '../segnalazione.dart';
import '../user.dart';
import 'login_exception.dart';

class PsycoDbConnector extends UserDbConnector {
  static psyChecks(User psy) async {
    LoginException.psyThrower(
      await AlboGetter.getFuturePsyco(
        psy.nome,
        psy.cognome,
        "", //TODO implementare l'ordine
        psy.password,
      ),
      psy.email,
      psy.nome,
      psy.cognome,
    );
  }

  static addUser(User user) async {
    await psyChecks(user);
    Response response = await post(
      Uri.parse(url +
          "PsycoCreate.php" +
          "?nome=" +
          user.nome +
          "&cognome=" +
          user.cognome +
          "&email=" +
          user.email +
          "&password=" +
          user.password),
    );
    LoginException.thrower(response.body);
  }

  static Future<Psyco> getUser(String email, String password) async {
    Response response = await post(Uri.parse(
      url +
          "PsycoGet.php" +
          "?email=" +
          email +
          "&password=" +
          User.crypt(password),
    ));
    LoginException.thrower(response.body);
    final json = jsonDecode(response.body);
    return Psyco.fromJson(json);
  }

  static Future<List<Segnalazione>> getSegnalazioni(User user) async {
    Response response = await post(Uri.parse(
      url +
          "PsycoGetSegnalazioni.php" +
          "?email=" +
          user.email +
          "&password=" +
          user.password,
    ));

    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((s) => Segnalazione.fromJson(s)).toList();
  }
}
