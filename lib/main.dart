import 'package:flutter/material.dart';
import '../psyco.dart';

// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/UserInfo', //'/main',
      routes: {
        //'/main': (context) => HomePage(),
        '/UserInfo': (context) => const UserInfo(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// This class is the home page of the application, it is the configuration for
// the state. It is stateful, meaning that it has a State object (defined below)
// that contains fields that affect how it looks.
// This class . It holds the values provided
// by the parent (in this case the App widget) and used by the build method of
// the State. Fields in a Widget subclass are always marked "final".

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState('', 'api', '');
}

class _UserInfoState extends State<UserInfo> {
  Psyco? psy;

  _UserInfoState(String nome, String cognome, String ordine) {
    psy = Psyco.fromAlbo(
      nome,
      cognome,
      ordine,
    );
  }

  // _initPsy(String nome, String cognome, String ordine) async {
  //   psy = await getPsyco(nome, cognome, ordine);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User info")),
      body: ListView(
        children: [
          Text(psy!.getNome()),
          Text(psy!.getCognome()),
          Text(psy!.getOrdine()),
          Text(psy!.getSezione()),
          Text(psy!.isValid()),
          Text(psy!.getPec()),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title = 'Flutter Demo Home Page';
  final int x = 10;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    // setState() rerun the build method below so that the display can reflect
    // the updated values. If we change _counter without calling setState(), nothing would happen
    setState(() => counter++);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console or the
          // "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              counter.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.ads_click_outlined),
      ), // This comma makes auto-formatting nicer for build methods.
    );
  }
}
