class LogoutResponse {
  String? status;
  String? pesan;

  LogoutResponse({
      this.status, 
      this.pesan,});

  LogoutResponse.fromJson(dynamic json) {
    status = json['status'];
    pesan = json['pesan'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['pesan'] = pesan;
    return map;
  }

}