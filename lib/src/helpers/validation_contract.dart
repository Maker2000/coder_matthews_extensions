import '../exceptions/exceptions.dart';
import '../extensions/object_extensions.dart';
import '../extensions/string_extensions.dart';
import 'helpers.dart';

class ValidationContract {
  /// Takes a bool [condition] and throws an [AppException] if it's false including list of optional error [ErrorDataAction] actions
  static void requires(bool condition, String title, String message, {List<ErrorDataAction> actions = const []}) {
    if (!condition) throw AppException(title, message, actions: actions);
  }

  /// Takes a nullable [val] and throws an [AppException] if it's null including list of optional error [ErrorDataAction] actions
  static void requireNotNull<T>(T? val, String title, String message, {List<ErrorDataAction> actions = const []}) {
    if (val.isNull) throw AppException(title, message, actions: actions);
  }

  /// Takes a nullable [val] and throws an [AppException] if it's not null including list of optional error [ErrorDataAction] actions
  static void requireNull<T>(T? val, String title, String message, {List<ErrorDataAction> actions = const []}) {
    if (val.isNotNull) throw AppException(title, message, actions: actions);
  }

  /// Takes a nullable string [val] and throws an [AppException] if it's null or empty including list of optional error [ErrorDataAction] actions
  static void requireNotNullOrEmpty(String? val, String title, String message,
      {List<ErrorDataAction> actions = const []}) {
    if (val.isNullOrEmpty) throw AppException(title, message, actions: actions);
  }

  /// Takes a nullable string [val] and throws an [AppException] if it's not null or empty including list of optional error [ErrorDataAction] actions
  static void requireNullOrEmpty(String? val, String title, String message,
      {List<ErrorDataAction> actions = const []}) {
    if (val.isNotNullOrEmpty) throw AppException(title, message, actions: actions);
  }
}
