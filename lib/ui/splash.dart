import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tokolina/shared/theme.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:app_settings/app_settings.dart';

import 'main_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    super.initState();

    Timer(Duration(seconds: 2), () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()), // this mainpage is your page to refresh
            (Route<dynamic> route) => false));

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
              Text('TOKO LINA',
                  style: whiteTextStyle.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
