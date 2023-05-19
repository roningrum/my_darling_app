class AgendaSuratResponse {
  AgendaSuratResponse({
    String? type,
    bool? status,
    Result? result,
  }) {
    _type = type;
    _status = status;
    _result = result;
  }

  AgendaSuratResponse.fromJson(dynamic json) {
    _type = json['type'];
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  String? _type;
  bool? _status;
  Result? _result;

  AgendaSuratResponse copyWith({
    String? type,
    bool? status,
    Result? result,
  }) =>
      AgendaSuratResponse(
        type: type ?? _type,
        status: status ?? _status,
        result: result ?? _result,
      );

  String? get type => _type;

  bool? get status => _status;

  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    num? count,
    num? page,
    num? maxPage,
    num? limit,
    String? dari,
    String? sampai,
    List<Data>? data,
  }) {
    _count = count;
    _page = page;
    _maxPage = maxPage;
    _limit = limit;
    _dari = dari;
    _sampai = sampai;
    _data = data;
  }

  Result.fromJson(dynamic json) {
    _count = json['count'];
    _page = json['page'];
    _maxPage = json['max_page'];
    _limit = json['limit'];
    _dari = json['dari'];
    _sampai = json['sampai'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  num? _count;
  num? _page;
  num? _maxPage;
  num? _limit;
  String? _dari;
  String? _sampai;
  List<Data>? _data;

  Result copyWith({
    num? count,
    num? page,
    num? maxPage,
    num? limit,
    String? dari,
    String? sampai,
    List<Data>? data,
  }) =>
      Result(
        count: count ?? _count,
        page: page ?? _page,
        maxPage: maxPage ?? _maxPage,
        limit: limit ?? _limit,
        dari: dari ?? _dari,
        sampai: sampai ?? _sampai,
        data: data ?? _data,
      );

  num? get count => _count;

  num? get page => _page;

  num? get maxPage => _maxPage;

  num? get limit => _limit;

  String? get dari => _dari;

  String? get sampai => _sampai;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['page'] = _page;
    map['max_page'] = _maxPage;
    map['limit'] = _limit;
    map['dari'] = _dari;
    map['sampai'] = _sampai;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    String? dari,
    String? noSurat,
    String? tglTerima,
    String? noAgenda,
    String? fileSurat,
    String? tanggal,
    String? tanggal2,
    String? jam,
    String? tempat,
    String? acara,
    String? disposisi1,
    String? disposisi2,
    String? disposisi3,
    List<PenerimaSurat>? penerimaSurat,
    String? dpBalik,
    String? dpBalikKasi,
    String? dpBalikStaff,
    String? semuaPenerima,
  }) {
    _id = id;
    _dari = dari;
    _noSurat = noSurat;
    _tglTerima = tglTerima;
    _noAgenda = noAgenda;
    _fileSurat = fileSurat;
    _tanggal = tanggal;
    _tanggal2 = tanggal2;
    _jam = jam;
    _tempat = tempat;
    _acara = acara;
    _disposisi1 = disposisi1;
    _disposisi2 = disposisi2;
    _disposisi3 = disposisi3;
    _penerimaSurat = penerimaSurat;
    _dpBalik = dpBalik;
    _dpBalikKasi = dpBalikKasi;
    _dpBalikStaff = dpBalikStaff;
    _semuaPenerima = semuaPenerima;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _dari = json['dari'];
    _noSurat = json['no_surat'];
    _tglTerima = json['tgl_terima'];
    _noAgenda = json['no_agenda'];
    _fileSurat = json['file_surat'];
    _tanggal = json['tanggal'];
    _tanggal2 = json['tanggal2'];
    _jam = json['jam'];
    _tempat = json['tempat'];
    _acara = json['acara'];
    _disposisi1 = json['disposisi1'];
    _disposisi2 = json['disposisi2'];
    _disposisi3 = json['disposisi3'];
    if (json['penerima_surat'] != null) {
      _penerimaSurat = [];
      json['penerima_surat'].forEach((v) {
        _penerimaSurat?.add(PenerimaSurat.fromJson(v));
      });
    }
    _dpBalik = json['dp_balik'];
    _dpBalikKasi = json['dp_balik_kasi'];
    _dpBalikStaff = json['dp_balik_staff'];
    _semuaPenerima = json['semua_penerima'];
  }

  String? _id;
  String? _dari;
  String? _noSurat;
  String? _tglTerima;
  String? _noAgenda;
  String? _fileSurat;
  String? _tanggal;
  String? _tanggal2;
  String? _jam;
  String? _tempat;
  String? _acara;
  String? _disposisi1;
  String? _disposisi2;
  String? _disposisi3;
  List<PenerimaSurat>? _penerimaSurat;
  String? _dpBalik;
  String? _dpBalikKasi;
  String? _dpBalikStaff;
  String? _semuaPenerima;

  Data copyWith({
    String? id,
    String? dari,
    String? noSurat,
    String? tglTerima,
    String? noAgenda,
    String? fileSurat,
    String? tanggal,
    String? tanggal2,
    String? jam,
    String? tempat,
    String? acara,
    String? disposisi1,
    String? disposisi2,
    String? disposisi3,
    List<PenerimaSurat>? penerimaSurat,
    String? dpBalik,
    String? dpBalikKasi,
    String? dpBalikStaff,
    String? semuaPenerima,
  }) =>
      Data(
        id: id ?? _id,
        dari: dari ?? _dari,
        noSurat: noSurat ?? _noSurat,
        tglTerima: tglTerima ?? _tglTerima,
        noAgenda: noAgenda ?? _noAgenda,
        fileSurat: fileSurat ?? _fileSurat,
        tanggal: tanggal ?? _tanggal,
        tanggal2: tanggal2 ?? _tanggal2,
        jam: jam ?? _jam,
        tempat: tempat ?? _tempat,
        acara: acara ?? _acara,
        disposisi1: disposisi1 ?? _disposisi1,
        disposisi2: disposisi2 ?? _disposisi2,
        disposisi3: disposisi3 ?? _disposisi3,
        penerimaSurat: penerimaSurat ?? _penerimaSurat,
        dpBalik: dpBalik ?? _dpBalik,
        dpBalikKasi: dpBalikKasi ?? _dpBalikKasi,
        dpBalikStaff: dpBalikStaff ?? _dpBalikStaff,
        semuaPenerima: semuaPenerima ?? _semuaPenerima,
      );

  String? get id => _id;

  String? get dari => _dari;

  String? get noSurat => _noSurat;

  String? get tglTerima => _tglTerima;

  String? get noAgenda => _noAgenda;

  String? get fileSurat => _fileSurat;

  String? get tanggal => _tanggal;

  String? get tanggal2 => _tanggal2;

  String? get jam => _jam;

  String? get tempat => _tempat;

  String? get acara => _acara;

  String? get disposisi1 => _disposisi1;

  String? get disposisi2 => _disposisi2;

  String? get disposisi3 => _disposisi3;

  List<PenerimaSurat>? get penerimaSurat => _penerimaSurat;

  String? get dpBalik => _dpBalik;

  String? get dpBalikKasi => _dpBalikKasi;

  String? get dpBalikStaff => _dpBalikStaff;

  String? get semuaPenerima => _semuaPenerima;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dari'] = _dari;
    map['no_surat'] = _noSurat;
    map['tgl_terima'] = _tglTerima;
    map['no_agenda'] = _noAgenda;
    map['file_surat'] = _fileSurat;
    map['tanggal'] = _tanggal;
    map['tanggal2'] = _tanggal2;
    map['jam'] = _jam;
    map['tempat'] = _tempat;
    map['acara'] = _acara;
    map['disposisi1'] = _disposisi1;
    map['disposisi2'] = _disposisi2;
    map['disposisi3'] = _disposisi3;
    if (_penerimaSurat != null) {
      map['penerima_surat'] = _penerimaSurat?.map((v) => v.toJson()).toList();
    }
    map['dp_balik'] = _dpBalik;
    map['dp_balik_kasi'] = _dpBalikKasi;
    map['dp_balik_staff'] = _dpBalikStaff;
    map['semua_penerima'] = _semuaPenerima;
    return map;
  }
}

class PenerimaSurat {
  final String nama;
  final String telp;

  PenerimaSurat(this.nama, this.telp);

  PenerimaSurat.fromJson(Map<String, dynamic> json)
      : nama = json['nama'],
        telp = json['telp'];
  Map<String, dynamic>toJson() =>{
    'nama' : nama,
    'telp': telp
  };
}
