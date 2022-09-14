import 'package:cyberbullism_bully/Model/learning/learning_element.dart';
import 'package:flutter/material.dart';

class LearningBigView extends StatefulWidget {
  final LearningElement element;

  const LearningBigView(this.element, {Key? key}) : super(key: key);

  @override
  State<LearningBigView> createState() => _LearningBigViewState();
}

class _LearningBigViewState extends State<LearningBigView> {
  double _fontIncrement = 0;

  get zoomFabs => IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: incrementFont,
              onPressed: incrementFont,
              child: const Icon(Icons.add),
              elevation: 0,
              mini: true,
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 6,
              endIndent: 6,
            ),
            FloatingActionButton(
              heroTag: decrementFont,
              onPressed: decrementFont,
              child: const Icon(Icons.remove),
              elevation: 0,
              mini: true,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Material(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          elevation: 10,
          child: zoomFabs,
        ),
        appBar: AppBar(title: Text(widget.element.title)),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text(
              widget.element.title,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.element.text,
              style: getStyleFrom(Theme.of(context).textTheme.bodyMedium),
              // Theme.of(context).textTheme.bo
            ),
          ],
        ),
      );

  void decrementFont() =>
      _fontIncrement > 0 ? setState(() => _fontIncrement--) : null;

  void incrementFont() =>
      _fontIncrement < 20 ? setState(() => _fontIncrement++) : null;

  getStyleFrom(TextStyle? style) =>
      style?.copyWith(fontSize: style.fontSize! + _fontIncrement);
}
