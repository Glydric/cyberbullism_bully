import 'package:cyberbullism_bully/Model/learning/get_learnings.dart';
import 'package:cyberbullism_bully/View/learning/learning_grid.dart';
import 'package:flutter/material.dart';

import 'package:cyberbullism_bully/Model/learning/learning_element.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Learning Page")),
        body: FutureBuilder(
          future: GetLearnings.learnings,
          builder: (_, AsyncSnapshot<List<LearningElement>> snapshot) =>
              snapshot.hasError
                  ? Text(snapshot.error.toString())
                  : snapshot.hasData
                      ? LearningGrid(snapshot.requireData)
                      : Container(),
        ),
      );
}
