import 'package:cyberbullism_bully/Model/learning/get_learnings.dart';
import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:cyberbullism_bully/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('User Crypt test', () {
    const password = "password";
    User user = User("name", "surname", "name.surname@mail.it", password);

    expect(password == user.password, false);
  });
  test("Get Learnings from asset folder", () async {
    // necessario perché GetLearning possa accedere a assets
    WidgetsFlutterBinding.ensureInitialized();

    List<LearningElement> learnings = await GetLearnings.learnings;

    expectLater(learnings.isNotEmpty, true);
  });
}
