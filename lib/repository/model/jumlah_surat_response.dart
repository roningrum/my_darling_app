class JumlahSuratResponse {
  JumlahSuratResponse({
    List<JumlahSuratBelum>? jumlahSuratBelum,
  }) {
    _jumlahSuratBelum = jumlahSuratBelum;
  }

  JumlahSuratResponse.fromJson(dynamic json) {
    if (json['jumlah_surat_belum'] != null) {
      _jumlahSuratBelum = [];
      json['jumlah_surat_belum'].forEach((v) {
        _jumlahSuratBelum?.add(JumlahSuratBelum.fromJson(v));
      });
    }
  }

  List<JumlahSuratBelum>? _jumlahSuratBelum;

  JumlahSuratResponse copyWith({
    List<JumlahSuratBelum>? jumlahSuratBelum,
  }) =>
      JumlahSuratResponse(
        jumlahSuratBelum: jumlahSuratBelum ?? _jumlahSuratBelum,
      );

  List<JumlahSuratBelum>? get jumlahSuratBelum => _jumlahSuratBelum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_jumlahSuratBelum != null) {
      map['jumlah_surat_belum'] =
          _jumlahSuratBelum?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// surat_udangan : 0
/// surat_umum : 0
/// dispo_balik : 0

class JumlahSuratBelum {
  JumlahSuratBelum({
    int? suratUdangan,
    int? suratUmum,
    int? dispoBalik,
  }) {
    _suratUdangan = suratUdangan;
    _suratUmum = suratUmum;
    _dispoBalik = dispoBalik;
  }

  JumlahSuratBelum.fromJson(dynamic json) {
    _suratUdangan = json['surat_udangan'];
    _suratUmum = json['surat_umum'];
    _dispoBalik = json['dispo_balik'];
  }

  int? _suratUdangan;
  int? _suratUmum;
  int? _dispoBalik;

  JumlahSuratBelum copyWith({
    int? suratUdangan,
    int? suratUmum,
    int? dispoBalik,
  }) =>
      JumlahSuratBelum(
        suratUdangan: suratUdangan ?? _suratUdangan,
        suratUmum: suratUmum ?? _suratUmum,
        dispoBalik: dispoBalik ?? _dispoBalik,
      );

  int? get suratUdangan => _suratUdangan;

  int? get suratUmum => _suratUmum;

  int? get dispoBalik => _dispoBalik;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['surat_udangan'] = _suratUdangan;
    map['surat_umum'] = _suratUmum;
    map['dispo_balik'] = _dispoBalik;
    return map;
  }
}
