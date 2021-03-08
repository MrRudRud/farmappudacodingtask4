import 'package:farmapp_udacoding/views/page_detail_view.dart';
import 'package:farmapp_udacoding/widgets/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:farmapp_udacoding/views/page_login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class PageHomeTabNews extends StatefulWidget {
  @override
  _PageHomeTabNewsState createState() => _PageHomeTabNewsState();
}

class _PageHomeTabNewsState extends State<PageHomeTabNews> {
  Future<List> getData() async {
    final response = await http.get("$baseUrl" + "/get_berita.php");
    return json.decode(response.body);
  }

  String username = "";
  String fullname = "";
  String nama = "";

  @override
  void initState() {
    super.initState();
    getDataPref();
  }

  getDataPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullname = sharedPreferences.getString("fullname");
      username = sharedPreferences.getString("username");

      print(nama);
    });
  }

  // Method Sign out
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PageLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, " + username),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, //buat hilangin tombol back
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AssetGiffyDialog(
                  image: Image.asset('assets/eevee.png'),
                  title: Text(
                    'Logout Confirmation',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  entryAnimation: EntryAnimation.TOP_RIGHT,
                  onOkButtonPressed: () {
                    signOut();
                  },
                  buttonOkColor: Theme.of(context).accentColor,
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemList(list: snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      backgroundColor: Colors.white,
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "Berita Utama",
                style: TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.bold, color: kGrey1),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DetailBerita(list, index);
                        }),
                      );
                    },
                    child: Container(
                      width: 300.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: list[index]['id_berita'],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage("$baseUrl" +
                                        "/galery/" +
                                        list[index]['foto']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            list[index]['judul'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: kTitleCard,
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "Berita Populer",
                style: TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.bold, color: kGrey1),
              ),
            ),
          ),
          ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetailBerita(list, index);
                      }),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 110.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 90.0,
                          height: 135.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage("$baseUrl" +
                                    "/galery/" +
                                    list[index]['foto']),
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index]['judul'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: kTitleCard,
                                ),
                                Text(
                                  list[index]['isi'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: kDetailContent,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      list[index]['tgl_berita'],
                                      style: kDetailContent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
