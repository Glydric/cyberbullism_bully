import '/Model/connect_db/user_connector.dart';
import 'package:flutter/material.dart';
import '/Model/user.dart';

class ListaSegnalazione extends StatefulWidget {
  final String messaggio = "";
  final int gravita = 0;

  //Ancora non inizializzata
  final Widget _segnalazioni = ListViewHome();

  const ListaSegnalazione({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaSegnalazioneState();
}

class ListaSegnalazioneState extends State<ListaSegnalazione> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Le tue segnalazioni"),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_sharp))),
        body: ListViewHome(),
        floatingActionButton: FloatingActionButton(
            onPressed: (() {
              debugPrint('Inserire qui la segnalazione "CARD"');
            }),
            child: const Icon(Icons.add)));
  }
}

class ListViewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text('Segnalazione 1'),
        Text('Segnalazione 2'),
        Text('Segnalazione 3'),
      ],
    );
  }
}
