import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toast/toast.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class SettingPage extends StatefulWidget {
  static String tag = 'setting-page';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  DateTime date = new DateTime.now();
  String hari='';
  String namafile='';
  String path = '';

  void Download() async {
    namafile = hari + '.jpg';
    print(namafile);
    StorageReference sr = await FirebaseStorage.instance.ref().child('images/${namafile}');
    String url = await sr.getDownloadURL();
    print(url);
    setState(() {
      path = url;
    });
  }

  void share() async {
    var request = await HttpClient().getUrl(Uri.parse(path));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Share Verse Image', 'amlog.jpg', bytes, 'image/jpg');
  }

  void DownloadToDevice() async {
    Directory dir = await getExternalStorageDirectory();
    File file = File('${dir.path}/${namafile}');

    StorageReference sr = await FirebaseStorage.instance.ref().child('images/${namafile}');
    await sr.writeToFile(file);
    Toast.show("Download Image Success", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    hari = date.day.toString();
    Download();
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Verse Image"),
      ),
      body: Center(
        child: Column(

          children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                  child: ListTile(
                    leading: Icon(Icons.image,
                    color: Colors.blueAccent,),
                    title: Text("Today's Verse Image", style: TextStyle(
                      fontSize: 20,
                    ),),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),

                Divider(),
            Image.network(path,
                width: 400,
                height: 400,
              ),
            Divider(),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: Text("Share To Others : ",
                  style: TextStyle(fontSize: 15
                  )),
            ),
            IconButton(
              icon: Icon(Icons.share,
              color: Colors.green),
              onPressed: share,
            ),
            RaisedButton(
              onPressed: DownloadToDevice,
              child: Text("Download to Device",
                  style: TextStyle(fontSize: 15.0, color: Colors.white
                  ),
              ),
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );

  }
}
