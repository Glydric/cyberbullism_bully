import 'package:flutter/material.dart';

import 'segnalazione_card.dart';


class ListaSegnalazioni extends StatelessWidget {
  final List<SegnalazioneCard> _list;

  const ListaSegnalazioni(this._list, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // lista anche relativamente lunga e che
    // riserva lo stesso spazio per ogni Container (segnalazione)

    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) => _list[index],
    );


    // return ListView(
    //     scrollDirection: Axis.vertical,
    //     padding: const EdgeInsets.all(8),
    //     children: <SegnalazioneCard>[

    //     ]
    //     );
  }
}
