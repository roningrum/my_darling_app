class ItemNotulenResponse {
  ItemNotulenResponse({
      this.itemNotulen,});

  ItemNotulenResponse.fromJson(dynamic json) {
    if (json['item_notulen'] != null) {
      itemNotulen = [];
      json['item_notulen'].forEach((v) {
        itemNotulen!.add(ItemNotulen.fromJson(v));
      });
    }
  }
  List<ItemNotulen>? itemNotulen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (itemNotulen != null) {
      map['item_notulen'] = itemNotulen?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ItemNotulen {
  ItemNotulen({
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
    this.statusNotif,
    this.isiSurat,
    this.jenisSurat,
    this.notifSuara,
    this.createdAt,
    this.updateAt,
    this.idSurat,
    this.idBidang,
    this.idStaff,
    this.notulen,
    this.keterangan,
    this.submitedAt,
    this.lastUpdate,});

  ItemNotulen.fromJson(dynamic json) {
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
    statusNotif = json['status_notif'];
    isiSurat = json['isi_surat'];
    jenisSurat = json['jenis_surat'];
    notifSuara = json['notif_suara'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    idSurat = json['id_surat'];
    idBidang = json['id_bidang'];
    idStaff = json['id_staff'];
    notulen = json['notulen'];
    keterangan = json['keterangan'];
    submitedAt = json['submited_at'];
    lastUpdate = json['last_update'];
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
  String? statusNotif;
  String? isiSurat;
  String? jenisSurat;
  String? notifSuara;
  String? createdAt;
  String? updateAt;
  String? idSurat;
  String? idBidang;
  String? idStaff;
  String? notulen;
  String? keterangan;
  dynamic submitedAt;
  String? lastUpdate;

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
    map['status_notif'] = statusNotif;
    map['isi_surat'] = isiSurat;
    map['jenis_surat'] = jenisSurat;
    map['notif_suara'] = notifSuara;
    map['created_at'] = createdAt;
    map['update_at'] = updateAt;
    map['id_surat'] = idSurat;
    map['id_bidang'] = idBidang;
    map['id_staff'] = idStaff;
    map['notulen'] = notulen;
    map['keterangan'] = keterangan;
    map['submited_at'] = submitedAt;
    map['last_update'] = lastUpdate;
    return map;
  }

}