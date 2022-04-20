import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Psyco {
  final url =
      "https://areariservata.psy.it/cgi-bin/areariservata/albo_nazionale.cgi";
  Map map = HashMap<dynamic, dynamic>();

  Psyco.fromAlbo(String nome, String cognome, String ordine) {
    getPsyco(nome, cognome, ordine);
  }

  getPsyco(String nome, String cognome, String ordine) async =>
      http.post(Uri.parse(url), body: {
        'name': nome,
        'cognome': cognome,
        'ordine': ordine,
        'azione': 'cerca'
      }).then((http.Response res) {
        if (res.statusCode < 200 || 400 < res.statusCode) {
          throw new Exception("Error while fetching data");
        }

        urlParse(res.body);
      });

  urlParse(String body) {
    var a = parse(body)
        .getElementsByClassName("testo_small")[0]
        .getElementsByTagName("td");
    map["cognome"] = getElement(a[0], '');
    map["nome"] = getElement(a[1], '');
    map["pec"] = a[2].attributes['data-pec'].toString();
    map["ordine"] = getElement(a[3], 'a');
    map["sezione"] = getElement(a[4], 'b');
    map["isValid"] = getElement(a[6], 'font').isEmpty;
  }

  String getElement(Element e, String tagName) {
    return tagName.isEmpty
        ? e.innerHtml.toString()
        : e.getElementsByTagName(tagName)[0].innerHtml.toString();
  }

  String getNome() {
    return map["nome"].toString();
  }

  String getCognome() {
    return map["cognome"].toString();
  }

  String getSezione() {
    return map["sezione"].toString();
  }

  String getOrdine() {
    return map["ordine"].toString();
  }

  String getPec() {
    return map["pec"].toString();
  }

  String isValid() {
    return map["isValid"].toString();
  }
}
