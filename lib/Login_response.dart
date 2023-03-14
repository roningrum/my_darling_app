class LoginResponse {
  String? status;
  String? pesan;
  String? accessToken;
  String? tokenType;

  LoginResponse(
      this.status, 
      this.pesan, 
      this.accessToken, 
      this.tokenType);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['pesan'] = pesan;
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    return map;
  }

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    pesan = json['pesan'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }


}