class LearningElement {
  final String title;
  final String text;
  LearningElement(String string)
      : title = string.split('\n')[0],
        text = string.substring(string.split('\n')[0].length);
}
