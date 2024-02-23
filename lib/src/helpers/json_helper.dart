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

  /// Use this function to add a single [JsonSerializerItem] item.
  void addSerializer<T>(JsonSerializerItem<T> item) {
    _serializers[T] = item;
  }

  /// Use this function to add multiple [JsonSerializerItem] items.
  void addSerializers(List<JsonSerializerItem> serializers) {
    for (var element in serializers) {
      _serializers[element.convertionType] = element;
    }
  }

  Map<Type, JsonSerializerItem> get serializers => _serializers;

  /// Use this function to decode a [Map<String, dynamic>] json object to [T] object.
  ///
  /// Example:
  /// ``` dart
  /// var jsonData = {...} // adding some data
  /// var data = JsonHelper.instance.decode<SomeClass>(jsonData);
  /// ```
  T? decode<T>(Map<String, dynamic> json) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper.decode(json);
  }

  /// Use this function to decode a [Map<String, dynamic>] json object to [dynamic] object
  /// by passing in the [Type] data type as a parameter.
  ///
  /// Example:
  /// ``` dart
  /// var jsonData = {...} // adding some data
  /// var data = JsonHelper.instance.decodeWithType(SomeClass, jsonData);
  /// ```
  dynamic decodeWithType(Type dataType, Map<String, dynamic> json) {
    var mapper = _serializers[dataType];
    if (mapper == null) return null;
    return mapper.decode(json);
  }

  /// Use this function to encode some [T] data to a [Map<String, dynamic>] json object.
  ///
  /// Example:
  /// ``` dart
  /// SomeClass data = SomeClass(...);
  /// var jsonData = JsonHelper.instance.encode(data); // convert to json data
  /// ```
  Map<String, dynamic>? encode<T>(T data) {
    var mapper = _serializers[T];
    if (mapper == null) return null;
    return mapper._privateEncode(data);
  }

  /// Use this function to encode some [dynamic] data (useful for more dynamic applications)
  /// to a [Map<String, dynamic>] json object.
  ///
  /// Example:
  /// ``` dart
  /// SomeClass data = SomeClass(...);
  /// var jsonData = JsonHelper.instance.encodeWithType(data); // convert to json data
  /// ```
  Map<String, dynamic>? encodeWithType(Type dataType, dynamic data) {
    var mapper = _serializers[dataType];
    if (mapper == null) return null;
    return mapper._privateEncode(data);
  }
}

/// Represents an item used by the [JsonHelper] class. It represents the class that holds both the encoder and
/// decoder of the [TEntity] object.
class JsonSerializerItem<TEntity> {
  /// The decoder of the class. It converts [Map<String, dynamic>] data to a [TEntity] object.
  TEntity Function(Map<String, dynamic> data) decode;

  /// The encoder class. It converts [TEntity] data to a [Map<String, dynamic>] object.
  final Map<String, dynamic> Function(TEntity data) encode;

  Map<String, dynamic> _privateEncode(dynamic data) => encode(data as TEntity);

  /// The [Type] of the [TEntity] object.
  Type get convertionType => TEntity;
  JsonSerializerItem({required this.decode, required this.encode});
}
