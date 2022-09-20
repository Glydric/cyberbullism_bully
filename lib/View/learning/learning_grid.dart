import 'package:cyberbullism_bully/View/learning/learning_card.dart';
import 'package:flutter/material.dart';

import '/Model/learning/learning_element.dart';

class LearningGrid extends StatefulWidget {
  final List<LearningElement> list;

  const LearningGrid(this.list, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LearningGridState();
}

class _LearningGridState extends State<LearningGrid> {
  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (_, int index) => learnings.elementAt(index),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
      );

  Iterable<LearningCard> get learnings => widget.list.map(LearningCard.new);
}
