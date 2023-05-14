class RecordJalanResponse {
  String? status;
  String? pesan;
  Data? data;

  RecordJalanResponse({this.status, this.pesan, this.data});

  RecordJalanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['pesan'] = this.pesan;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? nik;
  int? langkahTerekam;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.nik,
        this.langkahTerekam,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    langkahTerekam = json['langkah_terekam'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = this.nik;
    data['langkah_terekam'] = this.langkahTerekam;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
