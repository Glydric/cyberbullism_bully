import 'package:cyberbullism_bully/Model/connect_db/web_socket/user.dart';
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

  test('User Crypt test', () {
    const password = "password";
    User user = User("name", "surname", "name.surname@mail.it", password);

    expect(password == user.password, false);
  });
  test("Get Learnings from asset folder", () async {
    List learnings = await GetLearnings.learnings;

    expectLater(learnings.isNotEmpty, true);
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
