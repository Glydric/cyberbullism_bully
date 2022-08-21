import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cyberbullism_bully/Model/user.dart';

Digest hash(List<int> list) => sha256.convert(list);

List<int> utf(String text) => utf8.encode(text);
void main() {
  // ignore: avoid_print
  print(User.crypt("ciao"));
}
