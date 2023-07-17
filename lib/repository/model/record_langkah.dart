class RecordLangkah {
  RecordLangkah({
      this.nik, 
      this.langkah,
      this.cal,
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  RecordLangkah.fromJson(dynamic json) {
    nik = json['nik'];
    langkah = json['langkah'];
    cal = json['cal'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? nik;
  String? langkah;
  String? cal;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nik'] = nik;
    map['langkah'] = langkah;
    map['cal'] = cal;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}