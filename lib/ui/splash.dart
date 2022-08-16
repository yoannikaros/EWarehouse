import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tokolina/shared/theme.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:app_settings/app_settings.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState()  {

    cek();
    super.initState();
  }

  cek() async {

    if (await ConnectivityWrapper.instance.isConnected) {
      // TODO: implement initState

      Timer (Duration(seconds: 3), ()=>
          Navigator.pushNamed(context,'/main')
      );

    } else {
      AppSettings.openWIFISettings();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
                 'TOKO LINA',
                 style: whiteTextStyle.copyWith(
                   fontSize: 40,
                   fontWeight: FontWeight.bold,
                 )
             ),
           ],
         ),
        ),
      ),
    );
  }
}