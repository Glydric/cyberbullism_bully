import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'psyco.dart';

const String alboUrl = "https://areariservata.psy.it";

class PsycoUrlGetter {
  static Future<Psyco> getFuturePsyco(
          String nome, String cognome, String ordine, int i) async =>
      post(
        Uri.parse(alboUrl + "/cgi-bin/areariservata/albo_nazionale.cgi"),
        body: {
          'name': nome,
          'cognome': cognome,
          'ordine': ordine,
          'azione': 'cerca'
        },
      ).then(
        (Response res) {
          if (res.statusCode < 200 || 400 < res.statusCode) {
            throw Exception(
                "Error while fetching data, code ${res.statusCode}");
          }
          return Psyco(psycoUrlParser(i, res.body));
        },
      );

  static Map<String, dynamic> psycoUrlParser(int i, String body) {
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
    map["isValid"] = extractFromTag(table[_index + 5], 'font').innerHtml.isEmpty;
    map["pageUrl"] =
        alboUrl + extractFromTag(table[_index + 6], 'a').attributes['href'].toString();
    map["pec"] = "pec da reperire";
    return map;
  }

  static Element extractFromTag(Element e, String tagName) =>
      e.getElementsByTagName(tagName)[0];
}
