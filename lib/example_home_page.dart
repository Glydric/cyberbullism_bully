import 'package:flutter/material.dart';

// This class is the home page of the application, it is the configuration for
// the state. It is stateful, meaning that it has a State object (defined below)
// that contains fields that affect how it looks.
// This class . It holds the values provided
// by the parent (in this case the App widget) and used by the build method of
// the State. Fields in a Widget subclass are always marked "final".

class ExampleHomePage extends StatefulWidget {
  final String title = 'Flutter Demo Home Page';
  final int x = 10;

  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
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
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console or the
        // "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:',
              textAlign: TextAlign.right),
          Text(
            counter.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ), // This comma makes auto-formatting nicer for build methods.
    );
  }
}
