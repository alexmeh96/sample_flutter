import 'package:flutter/material.dart';
import 'package:search_app/pages/form_type_ahead_page.dart';
import 'package:search_app/pages/search_infinity_page.dart';
import 'package:search_app/pages/search_network_page.dart';
import 'package:search_app/pages/search_page.dart';
import 'package:search_app/pages/search_type_ahead_page.dart';

import 'model/Book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: buildBottomBar(),
    body: buildPages(),
  );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.blue);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Text('Local', style: style),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: Text('Network', style: style),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: Text('Network', style: style),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: Text('Network', style: style),
          label: 'Network',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return SearchPage();
      case 1:
        return SearchNetworkPage();
      case 2:
        return SearchTypeAheadPage();
      case 3:
        return FormTypeAheadPage();
      default:
        return Container();
    }
  }
}


