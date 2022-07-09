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
      ).then((response) => response.statusCode < 200 ||
              400 < response.statusCode
          ? throw Exception("Error ${response.statusCode} while fetching data")
          : psycoBodyParser(response.body, i));

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

  static Future<Map<String, dynamic>> addPec(Map<String, dynamic> map) async =>
      get(Uri.parse(map["pageUrl"])).then((response) {
        if (response.statusCode < 200 || 400 < response.statusCode) {
          throw Exception("Error ${response.statusCode} while fetching data");
        }
        map["pec"] = extractPec(response.body);
        return map;
      });

  static String extractPec(String body) => parse(body)
      .getElementsByClassName("main-container")[0]
      .getElementsByTagName("a")[0] // prendiamo il primo link
      .innerHtml;
}
