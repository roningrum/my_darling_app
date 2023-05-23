class TokenResponse {
  TokenResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  TokenResponse.fromJson(dynamic json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  String ?accessToken;
  String ?tokenType;
  int ?expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    return map;
  }
}
