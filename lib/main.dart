import 'package:flutter/material.dart';
import 'package:farmapp_udacoding/views/page_login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.orange[600],
        accentColor: Colors.orange[600],
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(fontSize: 18.0)),
      ),
      home: PageLogin(),
    );
  }
}
