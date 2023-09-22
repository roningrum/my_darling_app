class SendRecordLangkah {
  int? id;
  String? nik;
  int? langkah;
  int? cal;
  String? createdAt;
  String? updatedAt;

  SendRecordLangkah(
      {this.id,
        this.nik,
        this.langkah,
        this.cal,
        this.createdAt,
        this.updatedAt});

  SendRecordLangkah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    langkah = json['langkah'];
    cal = json['cal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nik'] = nik;
    data['langkah'] = langkah;
    data['cal'] = cal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}