
import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

const assetsPath = "assets/learning_resources";

class GetLearnings {
  // Future<List<LearningElement>> get elements async {
  static void elements() =>
    rootBundle
        .loadString(p.join(assetsPath, "Bullism.txt"))
        .then(LearningElement.new);
  
}
