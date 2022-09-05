import 'package:cyberbullism_bully/View/learning/learning_card.dart';
import 'package:flutter/material.dart';

class LearningGrid extends StatefulWidget {
  final List<LearningCard> _grid;

  const LearningGrid(this._grid, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LearningGridState();
}

class _LearningGridState extends State<LearningGrid> {
  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        padding: const EdgeInsets.all(20),
        itemCount: widget._grid.length,
        itemBuilder: (context, int index) => widget._grid[index],
      );
}
