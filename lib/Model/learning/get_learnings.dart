import 'dart:convert';

import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

const assetsPath = "assets/learning_resources";
get assets async => jsonDecode(await rootBundle.loadString('AssetManifest.json'));

class GetLearnings {
  static Future<List<LearningElement>> get elements => assets.key;

  static Future<LearningElement> element(String fileName) => rootBundle
      .loadString(p.join(assetsPath, fileName))
      .then(LearningElement.new);
}
