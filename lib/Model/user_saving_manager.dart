import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'psyco/psyco.dart';
import 'user.dart';

class UserSavingManager {
  static void saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("user", jsonEncode(user.toJson()));
  }

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString("user");

    if (userString == null) throw Exception("User not found");

    Map<String, dynamic> userMap =
        jsonDecode(userString) as Map<String, dynamic>;

    if (userMap["type"] == User) {
      return User.fromJson(userMap);
    } else {
      return Psyco.fromJson(userMap);
    }
  }
}
