import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LearningCard extends StatefulWidget {
  const LearningCard({Key? key}) : super(key: key);

  @override
  State<LearningCard> createState() => LearningCardState();
}

class LearningCardState extends State<LearningCard> {
  Icon fav = Icon(Icons.favorite_border);
  bool isntFav = true;
  String text = "";

  getData() async {
    String response = await rootBundle.loadString('learning_resources/turing.txt');
    setState(() {
      text = response;
    });
  }

  Widget build(BuildContext context) => Container(
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            elevation: 8,
            child: GridTile(
              header: ListTile(
                leading: IconButton(
                    icon: fav,
                    onPressed: () => setState(
                          () => isntFav
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                        )),
                trailing: Icon(Icons.download_rounded),
              ),
              child:
                  Center(child: Text(text)),
            ),
            color: Color.fromARGB(202, 223, 236, 82),
          )));
}
