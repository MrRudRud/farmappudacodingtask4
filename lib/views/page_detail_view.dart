import 'package:farmapp_udacoding/widgets/constans.dart';
import 'package:flutter/material.dart';

class DetailBerita extends StatelessWidget {
  final List list;
  final int index;

  DetailBerita(this.list, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(list[index]['judul']),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Image.network("$baseUrl" + "/galery/" + list[index]['foto']),
            Container(
              padding: EdgeInsets.all(32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            list[index]['judul'],
                            style: (Theme.of(context).textTheme.headline5),
                          ),
                        ),
                        Text(list[index]['tgl_berita']),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          list[index]['isi'],
                          style: kDetailContent,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
