class CatatanKesehatanResponse {
  CatatanKesehatanResponse({
      this.nik, 
      this.tglPemeriksa, 
      this.tempatP, 
      this.suhu, 
      this.lp, 
      this.tb, 
      this.bb, 
      this.imt, 
      this.rr, 
      this.hr, 
      this.sistole, 
      this.diastole, 
      this.gulaDarah, 
      this.nama,});

  CatatanKesehatanResponse.fromJson(dynamic json) {
    nik = json['nik'];
    tglPemeriksa = json['tgl_pemeriksa'];
    tempatP = json['tempat_p'];
    suhu = json['suhu'];
    lp = json['lp'];
    tb = json['tb'];
    bb = json['bb'];
    imt = json['imt'];
    rr = json['rr'];
    hr = json['hr'];
    sistole = json['sistole'];
    diastole = json['diastole'];
    gulaDarah = json['gula_darah'];
    nama = json['nama'];
  }
  String? nik;
  String? tglPemeriksa;
  String? tempatP;
  String? suhu;
  String? lp;
  String? tb;
  String? bb;
  String? imt;
  String? rr;
  String? hr;
  String? sistole;
  String? diastole;
  String? gulaDarah;
  String? nama;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nik'] = nik;
    map['tgl_pemeriksa'] = tglPemeriksa;
    map['tempat_p'] = tempatP;
    map['suhu'] = suhu;
    map['lp'] = lp;
    map['tb'] = tb;
    map['bb'] = bb;
    map['imt'] = imt;
    map['rr'] = rr;
    map['hr'] = hr;
    map['sistole'] = sistole;
    map['diastole'] = diastole;
    map['gula_darah'] = gulaDarah;
    map['nama'] = nama;
    return map;
  }

}