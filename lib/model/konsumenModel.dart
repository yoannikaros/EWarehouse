class kosnumen {
  List<DataKonsumen>? data;

  kosnumen({this.data});

  kosnumen.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataKonsumen>[];
      json['data'].forEach((v) {
        data!.add(new DataKonsumen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKonsumen {
  String? identitas;
  String? namaPelanggan;
  String? alamat;
  String? hutang;
  String? point;

  DataKonsumen(
      {this.identitas,
        this.namaPelanggan,
        this.alamat,
        this.hutang,
        this.point});

  DataKonsumen.fromJson(Map<String, dynamic> json) {
    identitas = json['identitas'];
    namaPelanggan = json['nama_pelanggan'];
    alamat = json['alamat'];
    hutang = json['hutang'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identitas'] = this.identitas;
    data['nama_pelanggan'] = this.namaPelanggan;
    data['alamat'] = this.alamat;
    data['hutang'] = this.hutang;
    data['point'] = this.point;
    return data;
  }
}