class KegiatanInternalResponse {
  KegiatanInternalResponse({
    this.kegiatanInternal,
  });

  KegiatanInternalResponse.fromJson(dynamic json) {
    if (json['kegiatan_internal'] != null) {
      kegiatanInternal = [];
      json['kegiatan_internal'].forEach((v) {
        kegiatanInternal?.add(KegiatanInternal.fromJson(v));
      });
    }
  }

  List<KegiatanInternal>? kegiatanInternal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (kegiatanInternal != null) {
      map['kegiatan_internal'] =
          kegiatanInternal?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class KegiatanInternal {
  KegiatanInternal({
    this.idInternal,
    this.idBidang,
    this.idSeksi,
    this.disposisi,
    this.kegiatan,
    this.lokasi,
    this.hari,
    this.tglKegiatan,
    this.jam,
    this.dihadiri,
    this.deskripsi,
    this.lastUpdate,
  });

  KegiatanInternal.fromJson(dynamic json) {
    idInternal = json['id_internal'];
    idBidang = json['id_bidang'];
    idSeksi = json['id_seksi'];
    disposisi = json['disposisi'];
    kegiatan = json['kegiatan'];
    lokasi = json['lokasi'];
    hari = json['hari'];
    tglKegiatan = json['tgl_kegiatan'];
    jam = json['jam'];
    dihadiri = json['dihadiri'];
    deskripsi = json['deskripsi'];
    lastUpdate = json['last_update'];
  }

  String? idInternal;
  String? idBidang;
  String? idSeksi;
  String? disposisi;
  String? kegiatan;
  String? lokasi;
  String? hari;
  String? tglKegiatan;
  String? jam;
  String? dihadiri;
  String? deskripsi;
  String? lastUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_internal'] = idInternal;
    map['id_bidang'] = idBidang;
    map['id_seksi'] = idSeksi;
    map['disposisi'] = disposisi;
    map['kegiatan'] = kegiatan;
    map['lokasi'] = lokasi;
    map['hari'] = hari;
    map['tgl_kegiatan'] = tglKegiatan;
    map['jam'] = jam;
    map['dihadiri'] = dihadiri;
    map['deskripsi'] = deskripsi;
    map['last_update'] = lastUpdate;
    return map;
  }
}
