class UserResponse {
  UserResponse({
    List<User>? user,
  }) {
    _user = user;
  }

  UserResponse.fromJson(dynamic json) {
    if (json['user'] != null) {
      _user = [];
      json['user'].forEach((v) {
        _user?.add(User.fromJson(v));
      });
    }
  }

  List<User>? _user;

  UserResponse copyWith({
    List<User>? user,
  }) =>
      UserResponse(
        user: user ?? _user,
      );

  List<User>? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class User {
  User({
    String? userId,
    String? username,
    String? password,
    String? nama,
    dynamic email,
    String? tglLahir,
    String? jenisKelamin,
    String? nik,
    String? telp,
    String? rule,
    String? foto,
    String? bidang,
    String? seksi,
    String? token,
    String? statusBarcode,
    String? createdAt,
    String? updateAt,
  }) {
    _userId = userId;
    _username = username;
    _password = password;
    _nama = nama;
    _email = email;
    _tglLahir = tglLahir;
    _jenisKelamin = jenisKelamin;
    _nik = nik;
    _telp = telp;
    _rule = rule;
    _foto = foto;
    _bidang = bidang;
    _seksi = seksi;
    _token = token;
    _statusBarcode = statusBarcode;
    _createdAt = createdAt;
    _updateAt = updateAt;
  }

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _username = json['username'];
    _password = json['password'];
    _nama = json['nama'];
    _email = json['email'];
    _tglLahir = json['tgl_lahir'];
    _jenisKelamin = json['jenis_kelamin'];
    _nik = json['nik'];
    _telp = json['telp'];
    _rule = json['rule'];
    _foto = json['foto'];
    _bidang = json['bidang'];
    _seksi = json['seksi'];
    _token = json['token'];
    _statusBarcode = json['status_barcode'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
  }

  String? _userId;
  String? _username;
  String? _password;
  String? _nama;
  dynamic _email;
  String? _tglLahir;
  String? _jenisKelamin;
  String? _nik;
  String? _telp;
  String? _rule;
  String? _foto;
  String? _bidang;
  String? _seksi;
  String? _token;
  String? _statusBarcode;
  String? _createdAt;
  String? _updateAt;

  User copyWith({
    String? userId,
    String? username,
    String? password,
    String? nama,
    dynamic email,
    String? tglLahir,
    String? jenisKelamin,
    String? nik,
    String? telp,
    String? rule,
    String? foto,
    String? bidang,
    String? seksi,
    String? token,
    String? statusBarcode,
    String? createdAt,
    String? updateAt,
  }) =>
      User(
        userId: userId ?? _userId,
        username: username ?? _username,
        password: password ?? _password,
        nama: nama ?? _nama,
        email: email ?? _email,
        tglLahir: tglLahir ?? _tglLahir,
        jenisKelamin: jenisKelamin ?? _jenisKelamin,
        nik: nik ?? _nik,
        telp: telp ?? _telp,
        rule: rule ?? _rule,
        foto: foto ?? _foto,
        bidang: bidang ?? _bidang,
        seksi: seksi ?? _seksi,
        token: token ?? _token,
        statusBarcode: statusBarcode ?? _statusBarcode,
        createdAt: createdAt ?? _createdAt,
        updateAt: updateAt ?? _updateAt,
      );

  String? get userId => _userId;

  String? get username => _username;

  String? get password => _password;

  String? get nama => _nama;

  dynamic get email => _email;

  String? get tglLahir => _tglLahir;

  String? get jenisKelamin => _jenisKelamin;

  String? get nik => _nik;

  String? get telp => _telp;

  String? get rule => _rule;

  String? get foto => _foto;

  String? get bidang => _bidang;

  String? get seksi => _seksi;

  String? get token => _token;

  String? get statusBarcode => _statusBarcode;

  String? get createdAt => _createdAt;

  String? get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['username'] = _username;
    map['password'] = _password;
    map['nama'] = _nama;
    map['email'] = _email;
    map['tgl_lahir'] = _tglLahir;
    map['jenis_kelamin'] = _jenisKelamin;
    map['nik'] = _nik;
    map['telp'] = _telp;
    map['rule'] = _rule;
    map['foto'] = _foto;
    map['bidang'] = _bidang;
    map['seksi'] = _seksi;
    map['token'] = _token;
    map['status_barcode'] = _statusBarcode;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    return map;
  }
}
