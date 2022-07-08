import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Psyco {
  Map map = HashMap<String, dynamic>();

  Future<Psyco> getFuturePsyco(
          String nome, String cognome, String ordine, int i) async =>
      http.post(// è anche possibile usare un http.get
        Uri.parse(
            "https://areariservata.psy.it/cgi-bin/areariservata/albo_nazionale.cgi"),
        body: {
          'name': nome,
          'cognome': cognome,
          'ordine': ordine,
          'azione': 'cerca'
        },
      ).then(
        (http.Response res) {
          if (res.statusCode < 200 || 400 < res.statusCode) {
            throw Exception(
                "Error while fetching data, code" + res.statusCode.toString());
          }
          urlParser(i, res.body);
          return this;
        },
      );

  void urlParser(int i, String body) {
    var table = parse(body)
        .getElementsByClassName("testo_small")[0]
        .getElementsByTagName("td");
    map["cognome"] = extractElement(table[0 + 8 * i]);
    map["nome"] = extractElement(table[1 + 8 * i]);
    map["pec"] = table[2 + 8 * i].attributes['data-pec'].toString();
    map["ordine"] = getElementWithTag(table[3 + 8 * i], 'a');
    map["sezione"] = getElementWithTag(table[4 + 8 * i], 'b');
    map["isValid"] = getElementWithTag(table[6 + 8 * i], 'font').isEmpty;
  }

  String getElementWithTag(Element e, String tagName) => tagName.isEmpty
        ? extractElement(e)
        : extractElement(e.getElementsByTagName(tagName)[0]);

  String extractElement(Element e) => e.innerHtml.toString();

  ///Getters
  String getNome() => map["nome"].toString();

  String getCognome() => map["cognome"].toString();

  String getSezione() => map["sezione"].toString();

  String getOrdine() => map["ordine"].toString();

  String getPec() => map["pec"].toString();
  
  String isValid() => map["isValid"].toString();
}
