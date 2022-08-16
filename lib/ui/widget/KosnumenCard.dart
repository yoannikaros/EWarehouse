import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tokolina/model/barangModels.dart';

class KonsumenCard extends StatefulWidget {
  final String barang;
  final String jenis;

  const KonsumenCard({Key? key,
    required this.barang,
    required this.jenis
  }) : super(key: key);

  @override
  State<KonsumenCard> createState() => _KonsumenCardState();
}

class _KonsumenCardState extends State<KonsumenCard> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Bounceable(
          onTap: (){},
          child: Card(
            color: Colors.black12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.only(top: 20,left: 20),
              child: Text('$barang'),
            ),
    ),
    )
    );

  }
      }

