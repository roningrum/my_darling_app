class TerimaSuratResponse {
  TerimaSuratResponse({
      this.success, 
      this.message,});

  TerimaSuratResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  int? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}