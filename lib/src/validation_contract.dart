import 'object_extensions.dart';
import 'string_extensions.dart';
import 'exceptions/app_exception.dart';

class ValidationContract {
  static void requires(bool condition, String title, String message) {
    if (!condition) throw AppException(title, message);
  }

  static void requireNotNull<T>(T? val, String title, String message) {
    if (val.isNull) throw AppException(title, message);
  }

  static void requireNull<T>(T? val, String title, String message) {
    if (val.isNotNull) throw AppException(title, message);
  }

  static void requireNotNullOrEmpty(String? val, String title, String message) {
    if (val.isNullOrEmpty) throw AppException(title, message);
  }

  static void requireNullOrEmpty(String? val, String title, String message) {
    if (val.isNotNullOrEmpty) throw AppException(title, message);
  }

  static void requiresWithCallback(
      bool condition, String title, String message, void Function() callback) {
    if (!condition) throw AppException(title, message, callback);
  }

  static void requireNotNullWithCallback<T>(
      T? val, String title, String message, void Function() callback) {
    if (val.isNull) throw AppException(title, message, callback);
  }

  static void requireNullWithCallback<T>(
      T? val, String title, String message, void Function() callback) {
    if (val.isNotNull) throw AppException(title, message, callback);
  }

  static void requireNotNullOrEmptyWithCallback(
      String? val, String title, String message, void Function() callback) {
    if (val.isNullOrEmpty) throw AppException(title, message, callback);
  }

  static void requireNullOrEmptyWithCallback(
      String? val, String title, String message, void Function() callback) {
    if (val.isNotNullOrEmpty) throw AppException(title, message, callback);
  }
}
