import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/theme.dart';

class bayarhutang extends StatefulWidget {
  bayarhutang({
    required this.identitas,
  });

  String identitas;

  @override
  State<bayarhutang> createState() => _bayarhutangState();
}

class _bayarhutangState extends State<bayarhutang> {
  final _formKey = GlobalKey<FormState>();

  //inisialize field
  var nama_pelanggan = TextEditingController();
  var hutang = TextEditingController();
  var bayarhutang = TextEditingController();


  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
  }

  //Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
        //you have to take the ip address of your computer.
        //because using localhost will cause an error
        //get detail data with id
          "http://192.168.100.193/toko/api/hutang/detail.php?identitas='${widget.identitas}'"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          nama_pelanggan = TextEditingController(text: data['nama_pelanggan']);
          hutang = TextEditingController(text: data['hutang']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("http://192.168.100.193/toko/api/hutang/post.php"),
        body: {
          "nama_pelanggan": nama_pelanggan.text,
          "hutang": bayarhutang.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'MANTAP!',
            message:
            'hutang berhasil dibayarkan mah!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
        // showSearch(context: context, delegate: SearchUser());

          //Navigator.pop(context);


      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: Text("Bayar hutang "),
        // ignore: prefer_const_literals_to_create_immutables
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                namaInput(),
                hutangInput(),
                bayarInput(),


                SizedBox(height: 40),

                Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Bayar Hutang",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //validate
                      if (_formKey.currentState!.validate()) {
                        //send data to database with this method
                        _onSubmit();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget namaInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama konsumen',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              )),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'aset/Username_Icon.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: nama_pelanggan,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Nama konsumen', hintStyle: subtitleTextStyle),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ngga boleh kosong mah';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget hutangInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hutang Konsumen',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              )),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'aset/poin.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: hutang,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Hutang Konsumen', hintStyle: subtitleTextStyle),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ngga boleh kosong mah';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget bayarInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jumlah hutang yang akan dibayarkan',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              )),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'aset/poin.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(

                      controller: bayarhutang,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Jumlah hutang yang akan dibayarkan', hintStyle: subtitleTextStyle),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ngga boleh kosong mah';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }




}
