class DataCheckupResponse {
  DataCheckupResponse({
      this.dataCheckup,});

  DataCheckupResponse.fromJson(dynamic json) {
    if (json['data_checkup'] != null) {
      dataCheckup = [];
      json['data_checkup'].forEach((v) {
        dataCheckup?.add(DataCheckup.fromJson(v));
      });
    }
  }
  List<DataCheckup>? dataCheckup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataCheckup != null) {
      map['data_checkup'] = dataCheckup?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DataCheckup {
  DataCheckup({
    this.idData,
    this.nik,
    this.berat,
    this.tglCekBerat,
    this.tinggi,
    this.tglCekTinggi,
    this.sistol,
    this.diastol,
    this.tglCekTensi,});

  DataCheckup.fromJson(dynamic json) {
    idData = json['id_data'];
    nik = json['nik'];
    berat = json['berat'];
    tglCekBerat = json['tgl_cek_berat'];
    tinggi = json['tinggi'];
    tglCekTinggi = json['tgl_cek_tinggi'];
    sistol = json['sistol'];
    diastol = json['diastol'];
    tglCekTensi = json['tgl_cek_tensi'];
  }
  String? idData;
  String? nik;
  String? berat;
  String? tglCekBerat;
  String? tinggi;
  String? tglCekTinggi;
  String? sistol;
  String? diastol;
  String? tglCekTensi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_data'] = idData;
    map['nik'] = nik;
    map['berat'] = berat;
    map['tgl_cek_berat'] = tglCekBerat;
    map['tinggi'] = tinggi;
    map['tgl_cek_tinggi'] = tglCekTinggi;
    map['sistol'] = sistol;
    map['diastol'] = diastol;
    map['tgl_cek_tensi'] = tglCekTensi;
    return map;
  }

}