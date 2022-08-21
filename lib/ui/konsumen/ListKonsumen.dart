import 'package:flutter/material.dart';
import 'package:tokolina/model/konsumenModel.dart';
import 'package:tokolina/shared/theme.dart';
import 'package:tokolina/ui/hutang/bayarhutang.dart';
import '../../Services/konsumen/ApiServiceKonsumen.dart';
import 'CariKonsumen.dart';
import 'package:intl/intl.dart';


class KonsumenKu extends StatefulWidget {
  @override
  _KonsumenKuState createState() => _KonsumenKuState();
}

class _KonsumenKuState extends State<KonsumenKu> {
  FetchKonsumenList _userList = FetchKonsumenList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Konsumen'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CariKosnumen());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        body: Container(
          color: utama,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<DataKonsumen>>(
              future: _userList.getKonsumenList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {

                      // Convert To String hutang
                      var hutangnya = '${data?[index].hutang}';
                      var hutangConventer = int.parse(hutangnya);

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
                                      bayarhutang(identitas: '${data?[index].identitas}')));
                        },
                        child: Stack(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                                    '${NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.  ').format(hutangConventer)}',
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
                                  // trailing: Text('More Info'),
                                ),
                              ),


                            Container(
                              margin: EdgeInsets.only(left: 370, top: 35),
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
                      );
                    });
              }),
        ),
      ),
    );
  }
}
