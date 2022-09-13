import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LearningCard extends StatefulWidget {
  const LearningCard({Key? key}) : super(key: key);

  @override
  State<LearningCard> createState() => LearningCardState();
}

class LearningCardState extends State<LearningCard> {
  Icon fav = const Icon(Icons.favorite_border);
  bool isFav = true; // TODO remove fav because of no implementation
  String text = "";

  getData() async {
    String response = await rootBundle.loadString('learning_resources/turing.txt');
    setState(() {
      text = response;
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 8,
        child: GridTile(
          header: ListTile(
            leading: IconButton(
                icon: fav,
                onPressed: () => setState(
                      () => isFav
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                    )),
            trailing: const Icon(Icons.download_rounded),
          ),
          child:
              Center(child: Text(text)),
        ),
        color: const Color.fromARGB(202, 223, 236, 82),
      ));
}
