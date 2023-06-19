class WalkingDataResponse {
  WalkingDataResponse({
      this.id, 
      this.nik, 
      this.langkah, 
      this.createdAt, 
      this.updatedAt,});

  WalkingDataResponse.fromJson(dynamic json) {
    id = json['id'];
    nik = json['nik'];
    langkah = json['langkah'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? nik;
  int? langkah;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nik'] = nik;
    map['langkah'] = langkah;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}