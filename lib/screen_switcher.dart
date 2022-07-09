import 'package:flutter/material.dart';

// importo pagine flutter
import 'example_home_page.dart';
import 'psyco/psyco_page.dart';

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({Key? key}) : super(key: key);

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {
  int _index = 0;
  final List _screen = const [
    ExampleHomePage(),
    ExampleHomePage(),
    UserInfo('', 'api', 'valeria')
  ];

  void _updateIndex(int value) {
    setState(() => _index = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _updateIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Learning (Later)",
            icon: Icon(Icons.description),
          ),
          BottomNavigationBarItem(
            label: "Home (Later)",
            icon: Icon(Icons.dangerous),
          ),
          BottomNavigationBarItem(
            label: "User (in work)",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
