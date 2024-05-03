import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

class GlobalErrorData extends ErrorData {
  GlobalErrorData({
    required super.message,
    required super.title,
    required super.exception,
    super.controllerSource,
    super.actions,
  });
}
