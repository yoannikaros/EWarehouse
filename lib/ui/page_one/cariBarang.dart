import 'package:flutter/material.dart';
import 'package:tokolina/Services/barang/apiserviceBarang.dart';
import 'package:tokolina/model/barangModels.dart';
import 'package:intl/intl.dart';
import '../../shared/theme.dart';
import '../operation/edit.dart';

class SearchUser extends SearchDelegate {
  FetchUserList _userList = FetchUserList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }



  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<DataBarang>>(
        future: _userList.getuserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DataBarang>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {

                // Convert To String Grosir
                var grosir = '${data?[index].hargagrosir}';
                var grosirConventer = int.parse(grosir);

                // Convert To String Umum
                var umum = '${data?[index].hargaumum}';
                var umumConventer = int.parse(umum);


                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        //routing into edit page
                        //we pass the id note
                        MaterialPageRoute(
                            builder: (context) =>
                                Edit(kode_item: '${data?[index].kodeItem}',)));

                  },
                  child: Container(
                    color: utama,
                    padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Cari Nama Barang'),
    );
  }
}