import 'package:flutter/material.dart';

class LearningGrid extends StatelessWidget {
  final List<LearningCard> _grid;
  @override
  const LearningGrid(this._grid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: _grid.length,
      itemBuilder: (context, int index) => _grid[index]);
}
