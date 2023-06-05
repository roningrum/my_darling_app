class SuratResponse {
  SuratResponse({
      this.surat,});

  SuratResponse.fromJson(dynamic json) {
    if (json['surat'] != null) {
      surat = [];
      json['surat'].forEach((v) {
        surat?.add(Surat.fromJson(v));
      });
    }
  }
  List<Surat>? surat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (surat != null) {
      map['surat'] = surat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Surat {
  Surat({
    this.id,
    this.noSurat,
    this.tglSurat,
    this.tglTerima,
    this.noAgenda,
    this.fileSurat,
    this.dari,
    this.perihalSurat,
    this.hari,
    this.tanggal,
    this.tanggal2,
    this.jam,
    this.tempat,
    this.acara,
    this.dpDari,
    this.status,
    this.disposisi1,
    this.disposisi2,
    this.disposisi3,
    this.penerima,
    this.dpBalik,
    this.dpBalikStaff,
    this.dpBalikKasi,
    this.statusNotif,
    this.isiSurat,
    this.jenisSurat,
    this.notifSuara,
    this.createdAt,
    this.updateAt,
    this.idDp,
    this.idSurat,
    this.idBidang,
    this.idSeksi,
    this.idStaff,
    this.dpHistoryDari,
    this.isiDp,
    this.statusDp,
    this.statusNotifHistory,
    this.notifSuaraH,
    this.notifDpBalik,
    this.tglDp,
    this.penerimaSurat,});

  Surat.fromJson(dynamic json) {
    id = json['id'];
    noSurat = json['no_surat'];
    tglSurat = json['tgl_surat'];
    tglTerima = json['tgl_terima'];
    noAgenda = json['no_agenda'];
    fileSurat = json['file_surat'];
    dari = json['dari'];
    perihalSurat = json['perihal_surat'];
    hari = json['hari'];
    tanggal = json['tanggal'];
    tanggal2 = json['tanggal2'];
    jam = json['jam'];
    tempat = json['tempat'];
    acara = json['acara'];
    dpDari = json['dp_dari'];
    status = json['status'];
    disposisi1 = json['disposisi1'];
    disposisi2 = json['disposisi2'];
    disposisi3 = json['disposisi3'];
    penerima = json['penerima'];
    dpBalik = json['dp_balik'];
    dpBalikStaff = json['dp_balik_staff'];
    dpBalikKasi = json['dp_balik_kasi'];
    statusNotif = json['status_notif'];
    isiSurat = json['isi_surat'];
    jenisSurat = json['jenis_surat'];
    notifSuara = json['notif_suara'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    idDp = json['id_dp'];
    idSurat = json['id_surat'];
    idBidang = json['id_bidang'];
    idSeksi = json['id_seksi'];
    idStaff = json['id_staff'];
    dpHistoryDari = json['dp_history_dari'];
    isiDp = json['isi_dp'];
    statusDp = json['status_dp'];
    statusNotifHistory = json['status_notif_history'];
    notifSuaraH = json['notif_suara_h'];
    notifDpBalik = json['notif_dp_balik'];
    tglDp = json['tgl_dp'];
    if (json['penerima_surat'] != null) {
      penerimaSurat = [];
      json['penerima_surat'].forEach((v) {
        penerimaSurat?.add(PenerimaSurat.fromJson(v));
      });
    }
  }
  String? id;
  String? noSurat;
  String? tglSurat;
  String? tglTerima;
  String? noAgenda;
  String? fileSurat;
  String? dari;
  String? perihalSurat;
  String? hari;
  String? tanggal;
  String? tanggal2;
  String? jam;
  String? tempat;
  String? acara;
  String? dpDari;
  String? status;
  String? disposisi1;
  String? disposisi2;
  String? disposisi3;
  String? penerima;
  String? dpBalik;
  String? dpBalikStaff;
  String? dpBalikKasi;
  String? statusNotif;
  String?  isiSurat;
  String? jenisSurat;
  String? notifSuara;
  String? createdAt;
  String? updateAt;
  String? idDp;
  String? idSurat;
  String? idBidang;
  String? idSeksi;
  String? idStaff;
  String? dpHistoryDari;
  String? isiDp;
  String? statusDp;
  String? statusNotifHistory;
  String? notifSuaraH;
  String? notifDpBalik;
  String? tglDp;
  List<PenerimaSurat>? penerimaSurat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['no_surat'] = noSurat;
    map['tgl_surat'] = tglSurat;
    map['tgl_terima'] = tglTerima;
    map['no_agenda'] = noAgenda;
    map['file_surat'] = fileSurat;
    map['dari'] = dari;
    map['perihal_surat'] = perihalSurat;
    map['hari'] = hari;
    map['tanggal'] = tanggal;
    map['tanggal2'] = tanggal2;
    map['jam'] = jam;
    map['tempat'] = tempat;
    map['acara'] = acara;
    map['dp_dari'] = dpDari;
    map['status'] = status;
    map['disposisi1'] = disposisi1;
    map['disposisi2'] = disposisi2;
    map['disposisi3'] = disposisi3;
    map['penerima'] = penerima;
    map['dp_balik'] = dpBalik;
    map['dp_balik_staff'] = dpBalikStaff;
    map['dp_balik_kasi'] = dpBalikKasi;
    map['status_notif'] = statusNotif;
    map['isi_surat'] = isiSurat;
    map['jenis_surat'] = jenisSurat;
    map['notif_suara'] = notifSuara;
    map['created_at'] = createdAt;
    map['update_at'] = updateAt;
    map['id_dp'] = idDp;
    map['id_surat'] = idSurat;
    map['id_bidang'] = idBidang;
    map['id_seksi'] = idSeksi;
    map['id_staff'] = idStaff;
    map['dp_history_dari'] = dpHistoryDari;
    map['isi_dp'] = isiDp;
    map['status_dp'] = statusDp;
    map['status_notif_history'] = statusNotifHistory;
    map['notif_suara_h'] = notifSuaraH;
    map['notif_dp_balik'] = notifDpBalik;
    map['tgl_dp'] = tglDp;
    if (penerimaSurat != null) {
      map['penerima_surat'] = penerimaSurat?.map((v) => v.toJson()).toList();
    }
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