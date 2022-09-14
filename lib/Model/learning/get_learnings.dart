import 'dart:async';
import 'dart:convert';

import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/services.dart';

class GetLearnings {
  static Future<List<LearningElement>> get learnings async =>
      getFutureKeys.then(getElements).then(cleanElements);

  static Future<dynamic> get getFutureAssets async =>
      getElement('AssetManifest.json').then((value) => json.decode(value));

  static Future<List<String>> get getFutureKeys => getFutureAssets.then(
        (value) => value.keys
            .where((String key) => key.contains("learning_resources"))
            .toList(),
      );

  static Future<List<Future<LearningElement>>> getElements(
          List<String> fileList) async =>
      fileList.map(getElement).map((e) => e.then(LearningElement.new)).toList();

  static Future<String> getElement(String filePath) =>
      rootBundle.loadString(filePath);

  static Future<List<LearningElement>> cleanElements(
      List<Future<LearningElement>> list) async {
    List<LearningElement> result = [];
    for (Future<LearningElement> element in list) {
      result.add(await element);
    }
    return result;
  }
}
