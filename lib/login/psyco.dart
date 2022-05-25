import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Psyco {
  Map map = HashMap<dynamic, dynamic>();

  Psyco();

  Future<Psyco> getFuturePsyco(String nome, String cognome, String ordine,
          int i) async => // è anche possibile usare un http.get
      http.post(
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
            throw Exception("Error while fetching data");
          }
          urlParser(i, res.body);
          return this;
        },
      );

  void urlParser(int i, String body) {
    var a = parse(body)
        .getElementsByClassName("testo_small")[0]
        .getElementsByTagName("td");
    map["cognome"] = getElement(a[0 + 8 * i], '');
    map["nome"] = getElement(a[1 + 8 * i], '');
    map["pec"] = a[2 + 8 * i].attributes['data-pec'].toString();
    map["ordine"] = getElement(a[3 + 8 * i], 'a');
    map["sezione"] = getElement(a[4 + 8 * i], 'b');
    map["isValid"] = getElement(a[6 + 8 * i], 'font').isEmpty;
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
