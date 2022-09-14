import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/material.dart';

class LearningCard extends StatefulWidget {
  final LearningElement learning;

  const LearningCard(this.learning, {Key? key}) : super(key: key);

  @override
  State<LearningCard> createState() => LearningCardState();
}

class LearningCardState extends State<LearningCard> {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 8,
        child: 
        GridTile(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(widget.learning.title)),
          ),
        ),
      );
}
