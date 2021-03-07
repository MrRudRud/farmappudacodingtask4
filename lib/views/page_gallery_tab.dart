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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Gallery(),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({Key key}) : super(key: key);

  // ignore: missing_return
  Future<List> fetchGalleryData() async {
    final response = await http.get("$baseUrl" + "/get_gallery.php");
    json.decode(response.body);
    print(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Gallery Example"),
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
                              image: new NetworkImage(snapshot.data[index]),
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
