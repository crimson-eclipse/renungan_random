import 'package:flutter/material.dart';
import 'home.dart';

class BgaPage extends StatefulWidget {
  static String tag = 'renungan-page';
  @override
  _BgaPageState createState() => _BgaPageState();
}

class _BgaPageState extends State<BgaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BGA'),
      ),
      body:
      Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[

              Text(
                "BACA GALI ALKITAB \n",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.left,
              ),

              Image.asset("assets/alkitab.webp"),

              Text(
                "\n BGA (Baca Gali Alkitab) adalah salah satu dari sekian banyak metode untuk mempelajari Alkitab, yang dikembangkan dan diperkenalkan oleh Scripture Union Indonesia. BGA merupakan metode eksegese yang praktis, memudahkan orang mengungkapkan isi perikop dalam Alkitab secara menyeluruh, menemukan intisari dan maknanya. \n"+
                "\n"+"Menurut pakarnya, keunggulan dari metode ini adalah: \n"+"\n"+
                "1. Saat di gunakan dalam kelompok/KTB/Kelompok Sel \n"+
                "Keunggulan metode ini saat digunakan dalam kelompok adalah adanya interaksi dari semua anggota kelompok. Jadi tidak hanya satu arah, bukan hanya pemimpin kelompoknya saja yang 'banyak bicara' dan anggotanya jadi pendengar setia, tetapi semua orang dalam kelompok tersebut ikut berinteraksi. Dalam BGA terdapat kata 'Gali'. Jadi saat menggali firman Tuhan berdasarkan tahap-tahap BGA, hal tersebut dilakukan secara bersama. \n \n"
                "2. Saat di gunakan sendiri/Saat Teduh Pribadi/Sate \n"+
                "Keunggulan metode ini saat digunakan sendiri, misalnya ketika saat teduh, maka metode ini membantu kita untuk bisa belajar firman Tuhan lebih baik. Acapkali ketika kita membaca bagian firman Tuhan tertentu kita bingung dan berkata 'apa gunanya perikop ini bagiku?' Nah, dengan BGA dapat menolong kita untuk menemukan aplikasi dari firman yang kita baca. \n\n"+
                "Mengunakan metode BGA bukan berarti kita meniadakan pimpin Roh Kudus. Tidak. Justru saat menggunakan metode ini kita berinteraksi antara akal budi yang Tuhan berikan kepada kita dengan pimpinan Roh Kudus. \n\n"
                "Metode BGA sendiri, terbagi atas 3 jenis atau varian, namun dalam tulisan ini penulisan mengkombinasikan ketiga varian ini.\n\n"+
                "Berikut langkah-langkahnya: \n"+"1. Berdoa \n"+"2. Bacalah \n"+"3. Renungkanlah"
                ,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),

      ),

    );
  }
}
