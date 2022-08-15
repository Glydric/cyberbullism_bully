import 'dart:convert';
import 'package:crypto/crypto.dart';

Digest hash(List<int> list) => sha256.convert(list);

List<int> utf(String text) => utf8.encode(text);
void main() {
  print(hash(utf("it1")));
}
