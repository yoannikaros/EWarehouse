import 'package:flutter/material.dart';
import 'package:tokolina/ui/konsumen/CariKonsumen.dart';
import 'package:tokolina/ui/konsumen/ListKonsumen.dart';
import 'package:tokolina/ui/main_pages.dart';
import 'package:tokolina/ui/operation/add.dart';
import 'package:tokolina/ui/operation/edit.dart';
import 'package:tokolina/ui/page_one/barang.dart';import 'package:tokolina/ui/splash.dart';
import 'shared/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // Navigator.pushNamed(context,'/main')
        '/': (context) => SplashPage(),
        '/main': (context) => MainPage(),
        '/barang': (context) => HomePage(),
        '/tambah': (context) => Add(),
        '/konsumen': (context) => KonsumenKu(),

      },
    );
  }
}
