import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/theme.dart';

//Readme
//terdapat 3 url api, baris nomor 46,67 dan 96

class Edit extends StatefulWidget {
  Edit({
    required this.kode_item,
  });

  String kode_item;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();

  //inisialize field
  var barang = TextEditingController();
  var jenis = TextEditingController();
  var hargaumum = TextEditingController();
  var hargagrosir = TextEditingController();
  var idsatuan = TextEditingController();

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
          "http://192.168.100.193/toko/api/barang/detail.php?kode_item='${widget.kode_item}'"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          barang = TextEditingController(text: data['barang']);
          jenis = TextEditingController(text: data['jenis']);
          hargaumum = TextEditingController(text: data['hargaumum']);
          hargagrosir = TextEditingController(text: data['hargagrosir']);
          idsatuan = TextEditingController(text: data['idsatuan']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse("http://192.168.100.193/toko/api/barang/update.php"),
        body: {
          "kode_item": widget.kode_item,
          "barang": barang.text,
          "jenis": jenis.text,
          "hargaumum": hargaumum.text,
          "hargagrosir": hargagrosir.text,
          "idsatuan": idsatuan.text
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);

        Navigator.pop(context);

      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete(context) async {
    try {
      return await http.post(
        Uri.parse("http://192.168.100.193/toko/api/barang/delete.php"),
        body: {
          "kode_item": widget.kode_item,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        // Remove all existing routes until the home.dart, then rebuild Home.
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);


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
        title: Text("Ubah " + barang.text),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //show dialog to confirm delete data
                      return AlertDialog(
                        content: Text('mamah yakin mau hapus barang ini?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check_circle),
                            onPressed: () => _onDelete(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
          )
        ],
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

                barangInput(),
                satuanInput(),
                hargagrosirinput(),
                hargaumuminput(),
                jumlahperdus(),

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
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //validate
                      if (_formKey.currentState!.validate()) {
                        //send data to database with this method
                        _onUpdate(context);
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


  Widget barangInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Barang',
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
                    'aset/barang_icon.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: barang,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan nama barangnya', hintStyle: subtitleTextStyle),
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
  Widget satuanInput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Satuan',
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
                      controller: jenis,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan satuan barang', hintStyle: subtitleTextStyle),
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
  Widget hargagrosirinput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Harga Grosir',
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
                    'aset/money.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: hargagrosir,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Harga Grosir', hintStyle: subtitleTextStyle),
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
  Widget hargaumuminput() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Harga Umum',
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
                    'aset/money.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: hargaumum,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Harga Umum', hintStyle: subtitleTextStyle),
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
  Widget jumlahperdus() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jumlah isi barang',
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
                      controller: idsatuan,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan jumlah isi barang',
                          hintStyle: subtitleTextStyle),
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
