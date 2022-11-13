import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cyberbullism_bully/Model/learning/get_learnings.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:cyberbullism_bully/Model/chat/message.dart';
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
  test("Message json parsing correct", () async {
    const jsons = [
      {
        "otherEmail": "p@1.it",
        "testo": "hello",
        "nome": "p",
        "cognome": "1",
        "data": "2022-11-13 22:11:56",
        "send_by_user": "0",
        "gravita": null
      },
      {
        "otherEmail": "l@1.it",
        "testo": "ora va bene",
        "nome": "l",
        "cognome": "1",
        "data": "2022-11-13 22:09:40",
        "send_by_user": "1",
        "gravita": '0'
      },
    ];
    for (var json in jsons) {
      var m = Message.fromJson(json);

      expect(m.otherEmail, json["otherEmail"]);
      expect(m.testo, json["testo"]);
      expect(m.nome, json["nome"]);
      expect(m.cognome, json["cognome"]);
      expect(m.data.toString().split('.')[0], json["data"]);
      expect(m.sendByUser, json["send_by_user"] == '1');
      expect(m.gravita, json["gravita"] == null ? null : int.parse(json["gravita"]!));
    }
  });
  test("User Crypt test", () async {
    const password = "it";
    const email = "l@1.it";

    User user = User("l", "1", email, password);
    debugPrint(user.password);

    expect(User.crypt(email, password), user.password);
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
