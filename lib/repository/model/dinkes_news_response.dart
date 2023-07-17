class DinkesNewsResponse {
  String? id;
  String? titel;
  String? url;
  String? tglPublish;
  String? fav;

  DinkesNewsResponse({
      this.id, 
      this.titel, 
      this.url, 
      this.tglPublish, 
      this.fav,});

  DinkesNewsResponse.fromJson(dynamic json) {
    id = json['id'];
    titel = json['titel'];
    url = json['url'];
    tglPublish = json['tgl_publish'];
    fav = json['fav'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['titel'] = titel;
    map['url'] = url;
    map['tgl_publish'] = tglPublish;
    map['fav'] = fav;
    return map;
  }

}