import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/material.dart';

class LearningBigView extends StatelessWidget {
  final LearningElement element;

  const LearningBigView(this.element, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Text(
              element.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(element.text),
          ],
        ),
      );
}
