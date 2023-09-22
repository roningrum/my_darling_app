import 'package:json_annotation/json_annotation.dart';

part 'storage_data.g.dart';

@JsonSerializable()
class StorageData<T>{
  StorageData({this.data});

  @JsonKey(name: 'data')
  @_Converter()
  final T? data;

  factory StorageData.fromJson(Map<String, dynamic> json) =>
      _$StorageDataFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StorageDataToJson(this);
}
class _Converter<T> implements JsonConverter<T, Object?>{
  const _Converter();

  @override
  T fromJson(Object? json) {

    throw UnimplementedError();
  }

  @override
  Object? toJson(T object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}