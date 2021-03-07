import 'package:flutter/material.dart';

import '../bottomNav.dart';

class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.orange,
        accentColor: Colors.orange,
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(fontSize: 18.0)),
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNav(),
    );
  }
}
