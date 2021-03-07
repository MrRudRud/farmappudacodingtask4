import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:farmapp_udacoding/widgets/constans.dart';
import 'dart:async';
import 'dart:convert';

class PageGalleryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[600],
        accentColor: Colors.orange[600],
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(fontSize: 18.0)),
      ),
      home: Gallery(),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({Key key}) : super(key: key);

  Future<List> fetchGalleryData() async {
    final response = await http.get("$baseUrl" + "/get_gallery.php");
    return json.decode(response.body);
    // print(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Farm Gallery",
            style: TextStyle(color: kGrey2),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List>(
            future: fetchGalleryData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new NetworkImage("$baseUrl" +
                                  "/galery/" +
                                  snapshot.data[index]['namafile']),
                              fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
