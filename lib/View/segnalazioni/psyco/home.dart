import 'package:flutter/material.dart';

import '/Model/user.dart';
import 'chat/psyco_chat_list.dart';
import 'segnalazione_list.dart';

class PsycoSegnalazioni extends StatefulWidget {
  final User user;

  const PsycoSegnalazioni(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PsycoSegnalazioniState();
}

class _PsycoSegnalazioniState extends State<PsycoSegnalazioni> {
  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => toPage(ListaSegnalazioni(widget.user)),
      ),
      body: PsycoChatList(widget.user));

  toPage(Widget page) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page,
      ));
}
