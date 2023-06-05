class KegiatanPppkResponse {
  KegiatanPppkResponse({
      this.kegiatanPppk,});

  KegiatanPppkResponse.fromJson(dynamic json) {
    if (json['kegiatan_pppk'] != null) {
      kegiatanPppk = [];
      json['kegiatan_pppk'].forEach((v) {
        kegiatanPppk?.add(KegiatanPppk.fromJson(v));
      });
    }
  }
  List<KegiatanPppk>? kegiatanPppk;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (kegiatanPppk != null) {
      map['kegiatan_pppk'] = kegiatanPppk?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class KegiatanPppk {
  KegiatanPppk({
    this.pppkId,
    this.kegiatan,
    this.lokasi,
    this.tglKegiatan1,
    this.tglKegiatan2,
    this.jam,
    this.deskripsi,
    this.pelaksana,
    this.penanggungJawab,
    this.noTelpPj,
    this.createdAt,
    this.updateAt,});

  KegiatanPppk.fromJson(dynamic json) {
    pppkId = json['pppk_id'];
    kegiatan = json['kegiatan'];
    lokasi = json['lokasi'];
    tglKegiatan1 = json['tgl_kegiatan1'];
    tglKegiatan2 = json['tgl_kegiatan2'];
    jam = json['jam'];
    deskripsi = json['deskripsi'];
    pelaksana = json['pelaksana'];
    penanggungJawab = json['penanggung_jawab'];
    noTelpPj = json['no_telp_pj'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }
  String? pppkId;
  String? kegiatan;
  String? lokasi;
  String? tglKegiatan1;
  String? tglKegiatan2;
  String? jam;
  String? deskripsi;
  String? pelaksana;
  String? penanggungJawab;
  String? noTelpPj;
  String? createdAt;
  String? updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pppk_id'] = pppkId;
    map['kegiatan'] = kegiatan;
    map['lokasi'] = lokasi;
    map['tgl_kegiatan1'] = tglKegiatan1;
    map['tgl_kegiatan2'] = tglKegiatan2;
    map['jam'] = jam;
    map['deskripsi'] = deskripsi;
    map['pelaksana'] = pelaksana;
    map['penanggung_jawab'] = penanggungJawab;
    map['no_telp_pj'] = noTelpPj;
    map['created_at'] = createdAt;
    map['update_at'] = updateAt;
    return map;
  }

}