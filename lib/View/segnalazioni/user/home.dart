import 'package:cyberbullism_bully/View/segnalazioni/user/lista_chat.dart';

import '/Model/user.dart';
import 'card_aggiunta.dart';
import 'package:flutter/material.dart';

import 'my_animation.dart';

class UserSegnalazione extends StatefulWidget {
  final User user;
  const UserSegnalazione(this.user, {Key? key}) : super(key: key);

  @override
  State<UserSegnalazione> createState() => _UserSegnalazioneState();
}

class _UserSegnalazioneState extends State<UserSegnalazione> {
  bool _isWriting = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            ListaChat(),
            // TextButton(
            //     child: Text("click"),
            //     onPressed: () => showDialog(
            //           context: context,
            //           builder: (_) => const AlertDialog(
            //             title: Text("hello"),
            //           ),
            //         )),
            Visibility(
              visible: _isWriting,
              child: MyAnimation(child: CardAggiunta(widget.user.email)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(_isWriting ? Icons.close : Icons.add),
          onPressed: () => setState(() => _isWriting = !_isWriting),
        ),
      );
}
