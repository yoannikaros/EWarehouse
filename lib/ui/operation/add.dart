import 'dart:async';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../shared/theme.dart';
import '../page_one/cariBarang.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

//Readme
//terdapat 1 url api, baris nomor 70

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  //inisialize field
  var barang = TextEditingController();
  var barcode = '99999';
  var idsatuan = TextEditingController();
  var jenis = TextEditingController();
  var hargaumum = TextEditingController();
  var hargagrosir = TextEditingController();
  var id = '99999';
  var qty = '99999';

  final List<String> items = [
    'PCS',
    'BKS',
    'Slop',
    'PAK',
    '/2 Pak',
    'LEMBAR',
    'RENCENG',
    'BUNGKUS',
    'IKET',
    '0.5',
    '1/4',
    'GLS',
    '/4',
    '/2',
    'KG',
    '/2 KG',
    '1/2 RTG',
    '1 KG',
    '1 ONS',
    '1/2 ONS',
    '1 GRAM',
    'BOX',
    'DUS',
    'RTG',
    'KARUNG',
    'TIMBANGAN',
    'Bal',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("http://192.168.100.193/toko/api/barang/post.php"),
        body: {
          "barang": barang.text,
          "barcode": barcode,
          "idsatuan": idsatuan.text,
          "jenis": selectedValue,
          "hargaumum": hargaumum.text,
          "hargagrosir": hargagrosir.text,
          "id": id,
          "qty": qty,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

       // Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
      // showSearch(context: context, delegate: SearchUser());

        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'MANTAP!',
            message:
            'Barang berhasil ditambahkan mah!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Timer(Duration(seconds: 5), () {
          Navigator.pop(context);
        });

      });
    } catch (e) {
      print(e);
    }
  }

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 5), () {
      _btnController.success();

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: Text("Tambah barang baru"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                barangInput(),
                TextDrop(),
                Drop(),
                // satuanInput(),
                hargagrosirinput(),
                hargaumuminput(),
                jumlahperdus(),
                SizedBox(height: 40),

                Container(
                  height: 60,
                  width: double.infinity,
                  child: RoundedLoadingButton(
                    controller: _btnController,
                    // style: ElevatedButton.styleFrom(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),

                    child: Text(
                      "Tambah",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //validate
                      if (_formKey.currentState!.validate()) {
                        //send data to database with this method
                        _onSubmit();
                        _doSomething;
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
                          hintText: 'Masukan nama barangnya',
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
                      controller: jenis,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Masukan satuan barang',
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
                          hintText: 'Masukan Harga Grosir',
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
                          hintText: 'Masukan Harga Umum',
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

  Widget TextDrop() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text('Satuan Barang',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: medium,
          )),
    );
  }

  Widget Drop() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      padding: EdgeInsets.only(left: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
          child: Row(
        children: [
          Image.asset(
            'aset/poin.png',
            width: 25,
          ),
          SizedBox(
            width: 16,
          ),
          DropdownButton2(
            isExpanded: true,
            hint: Text(
              'Pilih Satuan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
            buttonHeight: 40,
            buttonWidth: 480,
            itemHeight: 40,
            dropdownMaxHeight: 300,
            searchController: jenis,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: jenis,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Cari Satuan barang...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return (item.value.toString().contains(searchValue));
            },
            //This to clear the search value when you close the menu
            // onMenuStateChange: (isOpen) {
            //       if (!isOpen) {
            //         textEditingController.clear();
            //       }
            // },
          ),
        ],
      )),
    );
  }
}
