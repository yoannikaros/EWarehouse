import 'package:flutter/material.dart';
import 'package:tokolina/shared/theme.dart';

import '../../Services/barang/apiserviceBarang.dart';
import '../../model/barangModels.dart';

class Wbarang extends StatefulWidget {

  @override
  State<Wbarang> createState() => _WbarangState();
}

class _WbarangState extends State<Wbarang> {
  FetchUserList _userList = FetchUserList();
  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<List<DataBarang>>(
          future: _userList.getuserList(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            return ListView.builder(itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
            return Text('${data?[index].barang}');

            });
          }),
    );

    }
}

