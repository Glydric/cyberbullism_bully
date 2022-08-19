import 'package:cyberbullism_bully/View/segnalazioni/user/lista_chat.dart';

import '/Model/user.dart';
import 'card_aggiunta.dart';
import 'package:flutter/material.dart';

class UserSegnalazione extends StatefulWidget {
  final User user;
  const UserSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<UserSegnalazione> createState() => _UserSegnalazioneState();
}

class _UserSegnalazioneState extends State<UserSegnalazione> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListaChat(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => CardAggiunta(widget.user.email),
          ),
          child: const Icon(Icons.add),
        ),
      );
}
