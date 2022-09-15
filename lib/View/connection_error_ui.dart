import 'package:flutter/material.dart';

class ConnectionErrorUI extends StatelessWidget {
  const ConnectionErrorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.signal_wifi_bad),
            Text("Errore di connessione"),
          ],
        ),
      );
}
