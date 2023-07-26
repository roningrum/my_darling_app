class SendRecordLangkah {
  SendRecordLangkah({
      this.id, 
      this.nik, 
      this.langkah, 
      this.cal, 
      this.createdAt, 
      this.updatedAt,});

  SendRecordLangkah.fromJson(dynamic json) {
    id = json['id'];
    nik = json['nik'];
    langkah = json['langkah'];
    cal = json['cal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? nik;
  String? langkah;
  String? cal;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nik'] = nik;
    map['langkah'] = langkah;
    map['cal'] = cal;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}