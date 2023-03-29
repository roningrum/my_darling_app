class LoginResponse {
  String? status;
  String? pesan;
  User? user;
  String? accessToken;
  String? tokenType;


  LoginResponse(
      this.status, 
      this.pesan,
      this.user,
      this.accessToken, 
      this.tokenType);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['pesan'] = pesan;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    return map;
  }

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    pesan = json['pesan'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }
}

class User {
  int? id;
  String? nama;
  int? nik;

  User({this.id, this.nama, this.nik});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nik = json['nik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nama'] = nama;
    data['nik'] = nik;
    return data;
  }
}