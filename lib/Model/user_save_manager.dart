import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'psyco.dart';
import 'package:cyberbullism_bully/Model/user.dart';

class UserSavingManager {
  static const userKey = "user";

  static void saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString(userKey, jsonEncode(user.toJson()));
  }

  static Future<User> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final String? userString = pref.getString(userKey);

    if (userString == null) throw Exception("User not found");

    Map<String, dynamic> userMap = jsonDecode(userString);

    return userMap["type"] == "User"
        ? User.fromJson(userMap)
        : Psyco.fromJson(userMap);
  }

  static void removeUser() async {
    final pref = await SharedPreferences.getInstance();

    pref.remove(userKey);
  }
}
