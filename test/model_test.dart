import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cyberbullism_bully/Model/learning/get_learnings.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // necessario perché GetLearning possa accedere a assets
  // oppure per consentire a UserSavingManager di accedere ad una memoria
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });
  test("Get Learnings from asset folder", () async {
    List learnings = await GetLearnings.learnings;

    expectLater(learnings.isNotEmpty, true);
  });
  test("User Crypt test", () async {
    const password = "l@1.it";

    User user = User("l", "1", "l@1.it", "it");

    debugPrint(user.password);

    expect(user.password == User.crypt("l@1.it", "it"), true);
    expect(password == user.password, false);
  });
  /* test("User Websocket test", () async {

    final ws = UserWS(user, "p@1.it");
    final stream = ws.channel.stream;
    final sink = ws.channel.sink;
    stream.listen(onError: (event) => debugPrint(event));
    sink.add("reload ");
    // print(ws.messages);
    // expectLater(await ws.channel.stream.isEmpty, false);
  }); */
  /* test("User Save Manager Test", () async {
    User user = User("name", "surname", "name.surname@mail.it", "password");

    UserSavingManager.saveUser(user);

    expectLater(UserSavingManager.getUser(), user);
  }); */
}
