/// This [JsonHelper] class allows for more generic json encoding and decoding.
/// This is a singleton class which means that whether you call the default constructor or [instance],
/// it will be the same instance.
///
/// Remember to call [addSerializers] which accepts a list of [JsonSerializerItem] objects, or
/// [addSerializer] that accepts a single [JsonSerializerItem] to add more serializers to the helper.
///
/// Useage Example:
/// ``` dart
/// JsonHelper.instance.addSerializer(JsonSerializerItem(...)); // make this call in main.dart preferrably
/// ...
/// ...
/// Map<String, dynamic> jsonData = {...};
/// var data = JsonHelper.instance.decode<SomeClass>(jsonData); // will parse jsonData to a [SomeClass] object
/// ```
class JsonHelper {
  static final JsonHelper _singleton = JsonHelper._internal();
  factory JsonHelper() {
    return _singleton;
  }
  JsonHelper._internal();

  static JsonHelper get instance => _singleton;

  final Map<Type, JsonSerializerItem> _serializers = {};
  void addSerializer<T>(JsonSerializerItem<T> item) {
    _serializers[T] = item;
  }

  void addSerializers(List<JsonSerializerItem> serializers) {
    for (var element in serializers) {
      _serializers[element.convertionType] = element;
    }
  }

  T? decode<T>(Map<String, dynamic> json) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper.decode(json);
  }

  Map<String, dynamic>? encode<T>(T data) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper.encode(data);
  }
}

class JsonSerializerItem<TEntity> {
  TEntity Function(Map<String, dynamic> data) decode;
  final Map<String, dynamic> Function(TEntity data) encode;
  Type get convertionType => TEntity;
  JsonSerializerItem({required this.decode, required this.encode});
}
