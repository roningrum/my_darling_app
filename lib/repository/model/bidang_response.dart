class BidangResponse {
  BidangResponse({
    List<Bidang>? bidang,
  }) {
    _bidang = bidang;
  }

  BidangResponse.fromJson(dynamic json) {
    if (json['bidang'] != null) {
      _bidang = [];
      json['bidang'].forEach((v) {
        _bidang?.add(Bidang.fromJson(v));
      });
    }
  }

  List<Bidang>? _bidang;

  BidangResponse copyWith({
    List<Bidang>? bidang,
  }) =>
      BidangResponse(
        bidang: bidang ?? _bidang,
      );

  List<Bidang>? get bidang => _bidang;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bidang != null) {
      map['bidang'] = _bidang?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Bidang {
  Bidang({
    String? idBidang,
    String? bidang,
    String? alias,
  }) {
    _idBidang = idBidang;
    _bidang = bidang;
    _alias = alias;
  }

  Bidang.fromJson(dynamic json) {
    _idBidang = json['id_bidang'];
    _bidang = json['bidang'];
    _alias = json['alias'];
  }

  String? _idBidang;
  String? _bidang;
  String? _alias;

  Bidang copyWith({
    String? idBidang,
    String? bidang,
    String? alias,
  }) =>
      Bidang(
        idBidang: idBidang ?? _idBidang,
        bidang: bidang ?? _bidang,
        alias: alias ?? _alias,
      );

  String? get idBidang => _idBidang;

  String? get bidang => _bidang;

  String? get alias => _alias;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_bidang'] = _idBidang;
    map['bidang'] = _bidang;
    map['alias'] = _alias;
    return map;
  }
}
