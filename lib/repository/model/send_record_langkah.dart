/// id : 5
/// nik : "3374100104000004"
/// langkah : 300
/// cal : 40
/// created_at : "2023-09-22T10:20:40.000000Z"
/// updated_at : "2023-09-22T10:20:40.000000Z"

class SendRecordLangkah {
  SendRecordLangkah({
      int? id, 
      String? nik, 
      int? langkah, 
      double? cal,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _nik = nik;
    _langkah = langkah;
    _cal = cal;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  SendRecordLangkah.fromJson(dynamic json) {
    _id = json['id'];
    _nik = json['nik'];
    _langkah = json['langkah'];
    _cal = json['cal'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _nik;
  int? _langkah;
  double? _cal;
  String? _createdAt;
  String? _updatedAt;
SendRecordLangkah copyWith({  int? id,
  String? nik,
  int? langkah,
  double? cal,
  String? createdAt,
  String? updatedAt,
}) => SendRecordLangkah(  id: id ?? _id,
  nik: nik ?? _nik,
  langkah: langkah ?? _langkah,
  cal: cal ?? _cal,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  String? get nik => _nik;
  int? get langkah => _langkah;
  double? get cal => _cal;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nik'] = _nik;
    map['langkah'] = _langkah;
    map['cal'] = _cal;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}