class ItemDispoisisiResponse {
  ItemDispoisisiResponse({
    List<ItemDisposisi>? itemDisposisi,
  }) {
    _itemDisposisi = itemDisposisi;
  }

  ItemDispoisisiResponse.fromJson(dynamic json) {
    if (json['item_disposisi'] != null) {
      _itemDisposisi = [];
      json['item_disposisi'].forEach((v) {
        _itemDisposisi?.add(ItemDisposisi.fromJson(v));
      });
    }
  }

  List<ItemDisposisi>? _itemDisposisi;

  ItemDispoisisiResponse copyWith({
    List<ItemDisposisi>? itemDisposisi,
  }) =>
      ItemDispoisisiResponse(
        itemDisposisi: itemDisposisi ?? _itemDisposisi,
      );

  List<ItemDisposisi>? get itemDisposisi => _itemDisposisi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_itemDisposisi != null) {
      map['item_disposisi'] = _itemDisposisi?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemDisposisi {
  ItemDisposisi({
    String? id,
    String? nama,
  }) {
    _id = id;
    _nama = nama;
  }

  ItemDisposisi.fromJson(dynamic json) {
    _id = json['id'];
    _nama = json['nama'];
  }

  String? _id;
  String? _nama;

  ItemDisposisi copyWith({
    String? id,
    String? nama,
  }) =>
      ItemDisposisi(
        id: id ?? _id,
        nama: nama ?? _nama,
      );

  String? get id => _id;

  String? get nama => _nama;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama'] = _nama;
    return map;
  }
}
