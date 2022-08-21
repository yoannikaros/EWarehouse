import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tokolina/model/barangModels.dart';
import 'package:tokolina/model/konsumenModel.dart';

class FetchKonsumenList {
  var data = [];
  List<DataKonsumen> results = [];
  String urlList = 'http://192.168.100.193/toko/api/konsumen/list.php';

  Future<List<DataKonsumen>> getKonsumenList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {

        data = json.decode(response.body)['data'];
        results = data.map((e) => DataKonsumen.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.namaPelanggan!.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}