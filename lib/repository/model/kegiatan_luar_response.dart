class KegiatanLuarResponse {
  KegiatanLuarResponse({
    this.kegiatanLuar,
  });

  KegiatanLuarResponse.fromJson(dynamic json) {
    if (json['kegiatan_luar'] != null) {
      kegiatanLuar = [];
      json['kegiatan_luar'].forEach((v) {
        kegiatanLuar?.add(KegiatanLuar.fromJson(v));
      });
    }
  }

  List<KegiatanLuar>? kegiatanLuar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (kegiatanLuar != null) {
      map['kegiatan_luar'] = kegiatanLuar?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class KegiatanLuar {
  KegiatanLuar({
    this.id,
    this.idBidang,
    this.tglTerima,
    this.noSurat,
    this.asal,
    this.kegiatan,
    this.lokasi,
    this.tglKegiatan,
    this.jam,
    this.hari,
    this.deskripsi,
    this.disposisi,
    this.waktuDispo,
    this.petugas,
    this.createdAt,
  });

  KegiatanLuar.fromJson(dynamic json) {
    id = json['id'];
    idBidang = json['id_bidang'];
    tglTerima = json['tgl_terima'];
    noSurat = json['no_surat'];
    asal = json['asal'];
    kegiatan = json['kegiatan'];
    lokasi = json['lokasi'];
    tglKegiatan = json['tgl_kegiatan'];
    jam = json['jam'];
    hari = json['hari'];
    deskripsi = json['deskripsi'];
    disposisi = json['disposisi'];
    waktuDispo = json['waktu_dispo'];
    petugas = json['petugas'];
    createdAt = json['created_at'];
  }

  String? id;
  String? idBidang;
  String? tglTerima;
  String? noSurat;
  String? asal;
  String? kegiatan;
  String? lokasi;
  String? tglKegiatan;
  String? jam;
  String? hari;
  String? deskripsi;
  String? disposisi;
  String? waktuDispo;
  String? petugas;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['id_bidang'] = idBidang;
    map['tgl_terima'] = tglTerima;
    map['no_surat'] = noSurat;
    map['asal'] = asal;
    map['kegiatan'] = kegiatan;
    map['lokasi'] = lokasi;
    map['tgl_kegiatan'] = tglKegiatan;
    map['jam'] = jam;
    map['hari'] = hari;
    map['deskripsi'] = deskripsi;
    map['disposisi'] = disposisi;
    map['waktu_dispo'] = waktuDispo;
    map['petugas'] = petugas;
    map['created_at'] = createdAt;
    return map;
  }
}
