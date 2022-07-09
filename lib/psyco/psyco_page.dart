import 'package:flutter/material.dart';
import 'psyco.dart';
import 'psyco_url_getter.dart';

class UserInfo extends StatefulWidget {
  final String nome;
  final String cognome;
  final String ordine;

  const UserInfo(this.nome, this.cognome, this.ordine, {Key? key})
      : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("User info")), // use actions + button for searching
      body: Center(
        child: FutureBuilder<Psyco>(
          future: PsycoUrlGetter.getFuturePsyco(
              widget.nome, widget.cognome, widget.ordine, 0),
          builder: (BuildContext context, AsyncSnapshot<Psyco> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            Psyco psy = snapshot.requireData;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(psy.nome),
                Text(psy.cognome),
                Text(psy.ordine),
                Text(psy.sezione),
                Text(psy.isValid.toString()),
                Text(psy.email),
                Text(psy.pageUrl),
              ],
            );
          },
        ),
      ),
    );
  }
}
