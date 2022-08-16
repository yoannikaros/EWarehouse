import 'package:flutter/material.dart';
import 'package:tokolina/shared/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

  List _getTransaksi = [];

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getDataTransaksi();
  }

  Future _getDataTransaksi() async {
    try {
      final response = await http.get(Uri.parse(
        //you have to take the ip address of your computer.
        //because using localhost will cause an error
          "http://192.168.100.193/toko/api/transaksi/list.php"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // entry data to variabel list _get
        setState(() {
          _getTransaksi = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 20,
        itemBuilder: (context, data){

          // Convert To String subtotal
          var subtotalku = '${_getTransaksi[data]['subtotal']}';
          var subtotalConventer = int.parse(subtotalku);

          return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 17),
            width: 560,
            height: 125,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [

                Container(
                    margin: EdgeInsets.only(top: 32,left: 30),
                    child: Column(
                      children: [
                        Image.asset('aset/Username_Icon.png', width: 60,),
                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(top: 18,left: 108,bottom: 6),
                    child: Column(
                      children: [
                        Text('TRANSAKSI KONSUMEN', style: blackTextStyle.copyWith(fontSize: 12,fontWeight: regular),)
                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(left: 108,bottom: 6,top: 45),
                    child: Column(
                      children: [
                        Text('${_getTransaksi[data]['nama_pelanggan']}', style: blackTextStyle.copyWith(fontSize: 20,fontWeight: extraBold),)
                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(left: 108,top: 79),
                    child: Row(
                      children: [
                        Text('${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(subtotalConventer)}', style: utamaTextStyle.copyWith(fontSize: 19,fontWeight: FontWeight.bold),)
                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(left: 405,top: 43),
                    child: Column(
                      children: [
                        Text('${_getTransaksi[data]['date']}', style: utamaTextStyle.copyWith(fontSize: 20,fontWeight: extraBold),)
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      );
    });
  }

}
