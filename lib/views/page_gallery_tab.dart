// import 'package:farmapp_udacoding/views/page_galerry_detail.dart';
import 'package:farmapp_udacoding/widgets/constans.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, index) {
                    var list = snapshot.data;
                    return FeatureImage(
                      judul: list[index]['judul'],
                      desc: list[index]['descripsi'],
                      fileName: list[index]['namafile'],
                      index: index,
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

class FeatureImage extends StatelessWidget {
  final String judul;
  final String desc;
  final String fileName;
  final int index;

  const FeatureImage(
      {Key key, this.judul, this.desc, this.fileName, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: index,
        child: Material(
            child: InkWell(
          onTap: () {
            print(judul);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryDetail(
                  gallery: FeatureImage(
                    judul: judul,
                    desc: desc,
                    fileName: fileName,
                  ),
                ),
              ),
            );
          },
          child: GridTile(
            footer: SafeArea(
              child: Center(
                child: Text(
                  judul,
                  style: TextStyle(fontWeight: FontWeight.bold, color: kGrey3),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("$baseUrl" + "/galery/" + fileName),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class GalleryDetail extends StatelessWidget {
  final FeatureImage gallery;

  const GalleryDetail({Key key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${gallery.judul}'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('${gallery.desc}'),
              ],
            ),
          ),
        ));
  }
}
