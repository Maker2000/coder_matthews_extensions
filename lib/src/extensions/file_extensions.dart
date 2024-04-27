import 'dart:io';
import 'dart:math';

extension FileExn on File {
  static const _suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  static const _conversionSize = 1024;

  /// Returns file size in gigabytes
  Future<double> get sizeInGb => length().then((value) => value / pow(_conversionSize, 3));

  /// Returns file size in megabytes
  Future<double> get sizeInMb => length().then((value) => value / pow(_conversionSize, 2));

  /// Returns file size in kilobytes
  Future<double> get sizeInKb => length().then((value) => value / _conversionSize);

  /// Returns file size in bytes
  Future<int> get sizeInBytes => length();

  /// Returns the description of the file size
  ///
  /// Example:
  /// ```dart
  /// var file = File(....); // file is 1024 bytes big
  /// print(file.fileSizeDescription()); // prints 1 kb
  ///  ```
  Future<String> fileSizeDescription([int decimals = 2]) async {
    int bytes = await sizeInBytes;
    if (bytes <= 0) return "0 b";
    var i = (log(bytes) / log(_conversionSize)).floor();
    return '${(bytes / pow(_conversionSize, i)).toStringAsFixed(i == 0 ? 0 : decimals)} ${_suffixes[i].toLowerCase()}';
  }
}
