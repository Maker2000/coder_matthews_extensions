import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

class AppException implements Exception {
  final String title, message;
  final List<ErrorDataAction> actions;
  AppException(this.title, this.message, {this.actions = const []});
}
