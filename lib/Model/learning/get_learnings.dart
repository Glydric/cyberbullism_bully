import 'dart:convert';

import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/services.dart';

class GetLearnings {
  static Future<List<LearningElement>> get learnings async => json
      .decode(await rootBundle.loadString('AssetManifest.json'))
      .keys
      .where((String key) => key.contains("learning_resources"))
      // .map(print)
      .map(element)
      .map((e) async => await e)
      .toList();

  static Future<LearningElement> element(String filePath) =>
      rootBundle.loadString(filePath).then(LearningElement.new);
}
