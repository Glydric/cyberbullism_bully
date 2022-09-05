import 'package:flutter/material.dart';

import 'segnalazione_card.dart';

/// lista anche relativamente lunga e che
/// riserva lo stesso spazio per ogni Container (segnalazione)
class ListaSegnalazioni extends StatelessWidget {
  final List<SegnalazioneCard> _list;

  const ListaSegnalazioni(this._list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, int index) => _list[index]);
}
