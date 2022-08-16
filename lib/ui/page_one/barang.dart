import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'cariBarang.dart';
import 'package:tokolina/Services/barang/apiserviceBarang.dart';
import 'package:tokolina/model/barangModels.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../operation/add.dart';
import '../operation/edit.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //make list variable to accomodate all data from database

  FetchUserList _userList = FetchUserList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Barang'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        body: Container(
          color: utama,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<DataBarang>>(
              future: _userList.getuserList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {

                      // Convert To String Grosir
                      var grosir = '${data?[index].hargagrosir}';
                      var grosirConventer = int.parse(grosir);

                      // Convert To String Umum
                      var umum = '${data?[index].hargaumum}';
                      var umumConventer = int.parse(umum);

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              //routing into edit page
                              //we pass the id note
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Edit(kode_item: '${data?[index].kodeItem}')));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: utama,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${data?[index].kodeItem}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [

                                                Text(
                                                  '${data?[index].barang}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w800),
                                                ),

                                            SizedBox(height: 10),

                                            Row(
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  'GROSIR :  ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                Text(
                                                  '${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(grosirConventer)}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Text(
                                                  'UMUM   :  ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                Text(
                                                  '${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(umumConventer)}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )


                                          ])
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 390, top: 25),
                                    child: Text(
                                      '${data?[index].jenis}',
                                      style: TextStyle(
                                        color: utama,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                ],

                              ),

                            ),
                          ),
                        ),
                      );
                    });
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                //routing into add page
                MaterialPageRoute(builder: (context) => Add()));
          },
        ),
      ),
    );
  }
}
