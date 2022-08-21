import 'package:flutter/material.dart';
import 'package:tokolina/model/konsumenModel.dart';

import '../../Services/konsumen/ApiServiceKonsumen.dart';
import '../../shared/theme.dart';
import '../hutang/bayarhutang.dart';


class CariKosnumen extends SearchDelegate {
  FetchKonsumenList _userList = FetchKonsumenList();

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
    return FutureBuilder<List<DataKonsumen>>(
        future: _userList.getKonsumenList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DataKonsumen>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return Container(
                  color: utama,
                  padding: EdgeInsets.only(left: 20,right: 20, top: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          //routing into edit page
                          //we pass the id note
                          MaterialPageRoute(
                              builder: (context) =>
                                  bayarhutang(identitas: '${data?[index].identitas}')));
                    },
                    child: Stack(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${data?[index].point}',
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
                                          '${data?[index].namaPelanggan}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Rp. ',
                                              style: TextStyle(
                                                color: deskrisimenu,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${data?[index].hutang}',
                                              style: TextStyle(
                                                color: deskrisimenu,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 420, top: 42),
                          child: Text(
                            '${data?[index].alamat}',
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
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Pencarian Konsumen'),
    );
  }
}