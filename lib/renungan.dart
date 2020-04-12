import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper2.dart';
import 'home.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class RenunganPage extends StatefulWidget {
  static String tag = 'renungan-page';
  @override
  _RenunganPageState createState() => _RenunganPageState();
}

class _RenunganPageState extends State<RenunganPage> {

//  int getIndex(DateTime date, int length){
//    int remaining;
//
//    for(int i=0;i<length;i++){
//      if(!=-1){
//
//      }
//    }
//  }

//  List<Datas2> country;


  DatabaseHelper db = DatabaseHelper();
  DatabaseHelper2 dbhistory = DatabaseHelper2();

  List<Datas2> tamplilList;

  Datas2 dt;

  var indexArray = List(31);

  DateTime dateTime = DateTime.now();
  String date;
  String nampungtgl;

  void randIndex(List<Datas2> list) async {
    int size = list.length;

    for (int i = 0; i < size; i++) {
      bool ulang = true;

      while (ulang) {
        Random random = new Random();
        int x = random.nextInt(size);


        bool cek = true;

        for (int j = 0; j < i; j++) {
          if (indexArray[j] == x) {
            cek = false;
            break;
          }
        }

        if (cek) {
          ulang = false;
          indexArray[i] = x;
        }
      }
    }
    if (size <= 31) {
      int i = size;
      int j = 0;
      while (i <= 31) {
        indexArray[i] = indexArray[j];
        i++;
        j++;
        if (j == size) j = 0;
      }
    }
    return;
  }

  void nextRenungan() {
    setState(() {
//        dateTime.add(Duration(days: 1));
      dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day + 1);
      nampungtgl = DateFormat("dd MMMM yyyy").format(dateTime).toString();
      String hari = dateTime.day.toString();
      int renunganIndex = indexArray[dateTime.day];
      dt = Datas2(
          tamplilList[renunganIndex].judul, tamplilList[renunganIndex].ayat,
          tamplilList[renunganIndex].description);
    });
  }


//  var index = 1;

  @override
  Widget build(BuildContext context) {
    nampungtgl = DateFormat("dd MMMM yyyy").format(dateTime).toString();
    double c_width = MediaQuery
        .of(context)
        .size
        .width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bacaan Renungan'),
//        actions: _buildTanggal(),
      ),
      body:
      Center(
        child: Column(
          children: <Widget>[
            Divider(),
            Text('RENUNGAN HARI INI', style: TextStyle(fontSize: 30.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),),

            new FutureBuilder(
                future: db.getDataRenungan(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    tamplilList = snapshot.data;
                    randIndex(tamplilList);
                    int renunganidx = indexArray[dateTime.day - 1];
                    dt = Datas2(tamplilList[renunganidx].judul,
                        tamplilList[renunganidx].ayat,
                        tamplilList[renunganidx].description);


                    return Column(
                      children: <Widget>[
                        Card(
                          child: ListTile(
//                leading: Icon(Icons.calendar_today),
                            title: Text("Tanggal",
                                style: TextStyle(fontSize: 15.0)),
                            subtitle: Text(
                              nampungtgl,

                              style: TextStyle(fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Divider(),

                        Card(
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(),
                                  Container(
                                    width: c_width,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      dt.judul,
                                      style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    width: c_width,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      dt.ayat,
                                      style: TextStyle(
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
//                                  padding: const EdgeInsets.all(16.0),
                                    padding: const EdgeInsets.only(left: 10),
                                    width: c_width,
                                    height: 200,
                                    child: Text(
                                        dt.description
                                    ),
//                                  child: Column (
//                                  children: <Widget>[
//                                    Text(
//                                      dt.description,
//                                    ),
//                                  ],
//                                  ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                  } else if (!snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        RenunganNotFound(
                            "404 Belum ada Renungan", Icons.bubble_chart),
                      ],
                    );
                  } else {
                    return new Column();
                  }
                }
            ),


          ],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextRenungan();
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.green,
      ),
    );
  }

  Card RenunganNotFound(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(63, 195, 128, 1)),
          child: new InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/renunganPage');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 50.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 20.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}

//List<Widget> _buildTanggal() {
//  return <Widget>[
//    new IconButton(
//      icon: const Icon(
//        Icons.keyboard_arrow_right,
//        color: Colors.black,
//      ),
//      onPressed: null,
//    ),
//  ];
//}