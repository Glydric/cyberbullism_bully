import 'package:flutter/material.dart';

import '/Model/segnalazione.dart';
import '/Model/user.dart';
import '../user/chat/chat_view.dart';
import 'segnalazione_card.dart';

/// lista anche relativamente lunga e che
/// riserva lo stesso spazio per ogni Container (segnalazione)
class ListaSegnalazioni extends StatefulWidget {
  final List<Segnalazione> _list;

  final User user;

  const ListaSegnalazioni(this.user, this._list, {Key? key}) : super(key: key);

  @override
  State<ListaSegnalazioni> createState() => _ListaSegnalazioniState();
}

class _ListaSegnalazioniState extends State<ListaSegnalazioni> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget._list.length,
        itemBuilder: (context, int _index) => GestureDetector(
          onTap: () => openChat(_index),
          child: SegnalazioneCard(widget._list[_index]),
        ),
      );

  void openChat(int _index) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatView(widget.user, widget._list[_index].email),
        ),
      );
}
