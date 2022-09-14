import 'package:cyberbullism_bully/Model/learning/get_learnings.dart';
import 'package:cyberbullism_bully/View/learning/learning_grid.dart';
import 'package:flutter/material.dart';

import 'learning_card.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton(onPressed: () => GetLearnings.elements()),
        appBar: AppBar(title: const Text("Learning Page")),
        body: LearningGrid(getListOfLearning),
      );

  List<LearningCard> get getListOfLearning => [LearningCard()]; //TODO implement
}
