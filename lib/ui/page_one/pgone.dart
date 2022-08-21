import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:tokolina/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'cariBarang.dart';
import 'package:intl/intl.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List _getBeredar = [];
  List _gethutang = [];

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getDataBeredar();
    _getDataHutang();
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw 'ngga bisa jalan $uri';
    }
  }

  Future _getDataBeredar() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          "http://192.168.100.193/toko/api/konsumen/hutang.php"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // entry data to variabel list _get
        setState(() {
          _getBeredar = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getDataHutang() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          "http://192.168.100.193/toko/api/konsumen/top.php"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // entry data to variabel list _get
        setState(() {
          _gethutang = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: ListView(
        children: [
          navbar(),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 84),
                width: double.infinity,
                height: 945,
                decoration: BoxDecoration(
                    color: utama,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    TitleMenu(),
                    Memu(),
                    TitleKonsumen(),
                    SizedBox(
                      height: 500,
                      child: Container(child: konsumen()),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 45, left: 45),
                child: beredar(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget navbar() {
    return Container(
      margin: EdgeInsets.only(top: 55, left: 40),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'TOKO LINA SIGONG',
                style: whiteTextStyle.copyWith(
                    fontWeight: extraBold, fontSize: 30),
              ),
              SizedBox(
                width: 200,
              ),
              search()
            ],
          )
        ],
      ),
    );
  }

  Widget search() {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchUser());
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'aset/cari.png',
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget beredar() {

    return Stack(
      children: [
        Container(

          width: 514,
          height: 116,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, top: 18),
          width: 225,
          height: 77,
          decoration: BoxDecoration(
              color: utama, borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, beredarhutang) {

                      var yoan = '${_getBeredar[beredarhutang]['hutang']}';
                      var c = int.parse(yoan);


                      return Container(
                          margin: EdgeInsets.only(left: 30, top: 7),
                          child:

                          Text(
                            '${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(c)}',
                            style: whiteTextStyle.copyWith(
                                fontWeight: extraBold, fontSize: 22),
                          )



                      );
                    }),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 292, top: 43),
            child: Text(
              'HUTANG BEREDAR',
              style:
                  utamaTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
            ))
      ],
    );
  }

  Widget TitleMenu() {
    return Container(
      margin: EdgeInsets.only(top: 110, right: 390),
      child: Column(
        children: [
          Text(
            'MENU UTAMA',
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: extraBold),
          ),
        ],
      ),
    );
  }

  Widget Memu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 53),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                //Barang
                GestureDetector(
                  onTap: () async {

                    if (await ConnectivityWrapper.instance.isConnected) {
                      // TODO: implement initState
                      Navigator.pushNamed(context, '/barang');
                    } else {
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Wifi ngga nyambung mah!',
                          message:
                          'coba konekin wifinya mah!',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Timer(Duration(seconds: 5), () =>  AppSettings.openWIFISettings());
                    }

                  },
                  child: Container(
                    height: 194,
                    width: 166,
                    decoration: BoxDecoration(
                        color: menuColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Image.asset(
                          'aset/barang_icon.png',
                          width: 80,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          'BARANG',
                          style: blackTextStyle.copyWith(
                              fontSize: 15, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'MELIHAT DAFTAR BARANG',
                          style: deskripsiTextStyle.copyWith(
                              fontSize: 10, fontWeight: medium),
                        ),
                      ],
                    ),
                  ),
                ),

                //Tambah Barang
                GestureDetector(
                  onTap: () async {
                    if (await ConnectivityWrapper.instance.isConnected) {
                      // TODO: implement initState
                      Navigator.pushNamed(context, '/tambah');
                    } else {
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Wifi ngga nyambung mah!',
                          message:
                          'coba konekin wifinya mah!',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Timer(Duration(seconds: 5), () =>  AppSettings.openWIFISettings());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 194,
                    width: 166,
                    decoration: BoxDecoration(
                        color: menuColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Image.asset(
                          'aset/tambah.png',
                          width: 90,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          'TAMBAH BARANG',
                          style: blackTextStyle.copyWith(
                              fontSize: 15, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'UNTUK MENAMBAH BARANG',
                          style: deskripsiTextStyle.copyWith(
                              fontSize: 10, fontWeight: medium),
                        ),
                      ],
                    ),
                  ),
                ),

                //Konsumen
                GestureDetector(
                  onTap: () async {

                    if (await ConnectivityWrapper.instance.isConnected) {
                      // TODO: implement initState
                      Navigator.pushNamed(context, '/konsumen');
                    } else {
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Wifi ngga nyambung mah!',
                          message:
                          'coba konekin wifinya mah!',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Timer(Duration(seconds: 5), () =>  AppSettings.openWIFISettings());
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 194,
                    width: 166,
                    decoration: BoxDecoration(
                        color: menuColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Image.asset(
                          'aset/Username_Icon.png',
                          width: 70,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          'KONSUMEN',
                          style: blackTextStyle.copyWith(
                              fontSize: 15, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'MELIHAT DAFTAR KONSUMEN',
                          style: deskripsiTextStyle.copyWith(
                              fontSize: 10, fontWeight: medium),
                        ),
                      ],
                    ),
                  ),
                ),

                //Transaksi
                GestureDetector(
                  onTap: () {
                    final Uri url = Uri(
                        scheme: 'http',
                        host: '192.168.100.193',
                        path: '/toko/transaksi/');

                    _launchUrl(url);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 194,
                    width: 166,
                    decoration: BoxDecoration(
                        color: menuColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'aset/transaksi.png',
                          width: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'TRANSAKSI',
                          style: blackTextStyle.copyWith(
                              fontSize: 15, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'TRANSAKSI JUALAN',
                          style: deskripsiTextStyle.copyWith(
                              fontSize: 10, fontWeight: medium),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget TitleKonsumen() {
    return Container(
      margin: EdgeInsets.only(top: 27, right: 230),
      child: Column(
        children: [
          Text(
            'TOP 10 HUTANG TERBANYAK',
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: extraBold),
          ),
        ],
      ),
    );
  }

  Widget konsumen() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, DataHutang) {

        // Convert To String subtotal
        var hutangnya = '${_gethutang[DataHutang]['hutang']}';
        var hutangConventer = int.parse(hutangnya);

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 490,
                height: 108,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 32, left: 30),
                        child: Column(
                          children: [
                            Image.asset(
                              'aset/Username_Icon.png',
                              width: 50,
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 18, left: 108, bottom: 6),
                        child: Column(
                          children: [
                            Text(
                              'KONSUMEN',
                              style: blackTextStyle.copyWith(
                                  fontSize: 10, fontWeight: regular),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 108, bottom: 6, top: 40),
                        child: Column(
                          children: [
                            Text(
                              '${_gethutang[DataHutang]['nama_pelanggan']}',
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 108, top: 66),
                        child: Column(
                          children: [
                            Text(
                              '${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(hutangConventer)}',
                              style: utamaTextStyle.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 345, top: 43),
                        child: Column(
                          children: [
                            Text(
                              '${_gethutang[DataHutang]['alamat']}',
                              style: utamaTextStyle.copyWith(
                                  fontSize: 15, fontWeight: extraBold),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
