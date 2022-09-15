import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:cyberbullism_bully/View/learning/learning_big_view.dart';
import 'package:flutter/material.dart';

class LearningCard extends StatefulWidget {
  final LearningElement element;

  const LearningCard(this.element, {Key? key}) : super(key: key);

  @override
  State<LearningCard> createState() => LearningCardState();
}

class LearningCardState extends State<LearningCard> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(
                widget.element.title,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(widget.element.text),
            ),
          ),
        ),
        onTap: () => openBigView(widget.element),
      );

  void openBigView(LearningElement element) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => LearningBigView(element),
        ),
      );
}
