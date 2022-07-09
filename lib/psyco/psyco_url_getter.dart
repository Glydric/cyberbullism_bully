import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'psyco.dart';

const String alboUrl = "https://areariservata.psy.it";

class PsycoUrlGetter {
  static getFuturePsyco(String nome, String cognome, String ordine, int i) =>
      getFutureMap(nome, cognome, ordine, i)
          .then((map) => addPec(map))
          .then((map) => Psyco(map));

  static Future<Map<String, dynamic>> getFutureMap(
          String nome, String cognome, String ordine, int i) async =>
      get(
        Uri.parse(alboUrl +
            "/cgi-bin/areariservata/albo_nazionale.cgi" +
            "?azione=cerca&name=$nome&cognome=$cognome&ordine=$ordine"),
      ).then((response) {
        statusCodeCheck(response.statusCode);
        return psycoBodyParser(response.body, i);
      });

  /// Tasforma il body in una map
  static Map<String, dynamic> psycoBodyParser(String body, int i) {
    Map<String, dynamic> map = HashMap();
    int _index = 8 * i;

    List<Element> table = parse(body)
        .getElementsByClassName(
            "testo_small")[0] // questo è il nome della tabella
        .getElementsByTagName("td"); // prendiamo tutte le celle
    map["cognome"] = table[_index + 0].innerHtml;
    map["nome"] = table[_index + 1].innerHtml;
    map["ordine"] = extractFromTag(table[_index + 2], 'a').innerHtml;
    map["sezione"] = extractFromTag(table[_index + 3], 'b').innerHtml;
    map["isValid"] =
        extractFromTag(table[_index + 5], 'font').innerHtml.isEmpty.toString();
    map["pageUrl"] = alboUrl +
        extractFromTag(table[_index + 6], 'a').attributes['href'].toString();
    return map;
  }

  static Element extractFromTag(Element e, String tagName) =>
      e.getElementsByTagName(tagName)[0];

  /// Prende in input la map
  /// si connette alla pagina personale dello psicologo
  /// estrae la pec e la aggiunge alla map
  static Future<Map<String, dynamic>> addPec(Map<String, dynamic> map) async =>
      get(Uri.parse(map["pageUrl"])).then((response) {
        statusCodeCheck(response.statusCode);
        map["pec"] = extractPecFromPersonalPage(response.body);
        return map;
      });

  static String extractPecFromPersonalPage(String body) => parse(body)
      .getElementsByClassName("main-container")[0]
      .getElementsByTagName("a")[0] // prendiamo il primo link
      .innerHtml;

  static statusCodeCheck(int statusCode) {
    if (statusCode < 200 || 400 < statusCode) {
      throw Exception("Error $statusCode while fetching data");
    }
  }
}
