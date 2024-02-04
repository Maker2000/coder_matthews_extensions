class JsonSerializerHelper {
  static final JsonSerializerHelper _singleton = JsonSerializerHelper._internal();
  factory JsonSerializerHelper() {
    return _singleton;
  }
  JsonSerializerHelper._internal();

  static JsonSerializerHelper get instance => _singleton;

  final Map<Type, ({T Function<T>(dynamic) fromJson, Map<String, dynamic> Function<T>(T data) toJson})> _serializers =
      {};
  void addSerializer<T>(JsonSerializerItem item) {
    _serializers[T] = (fromJson: item.fromJson, toJson: item.toJson);
  }

  void addSerializers(List<JsonSerializerItem> serializers) {
    for (var element in serializers) {
      _serializers[element.convertionType] = (fromJson: element.fromJson, toJson: element.toJson);
    }
  }

  T? decodeJsonToObject<T>(dynamic json) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper.fromJson(json);
  }

  Map<String, dynamic>? encodeObjectToJson<T>(T data) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper.toJson(data);
  }
}

class JsonSerializerItem<T> {
  final T Function<T>(dynamic) fromJson;
  final Map<String, dynamic> Function<T>(T data) toJson;
  Type get convertionType => T;
  JsonSerializerItem({required this.fromJson, required this.toJson});
}
