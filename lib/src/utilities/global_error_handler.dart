import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../widgets/widgets.dart';

/// Implement this interface to allow for error handling controllers.
abstract interface class IAppErrorHandler {
  void onError();
}

/// A [GlobalErrorHandler] to ahndle uncaught errors globally. The [convertException] function should be used to check the exception and return a
/// nullable [ErrorData] object.
///
/// This can be used with the riperpod package
///
/// Use the [handleFlutterError] function to handle the flutter errors and [handleNonFlutterError] to handle the other errors. In your main.dart file Example:
/// ```dart
/// var errorHandler = GlobalErrorHandler(...); // instantiate the error handler
/// void main() {
/// runZonedGuarded(() {
///   FlutterError.onError = (details) {
///    errorHandler.handleFlutterError(details);
///  };
///   runApp(const MyApp()); // entry point into app
///  }, (error, stack) {
///    errorHandler.handleNonFlutterError(error, stack);
///  });
/// }
/// ```
///
/// Remember to assign the [navigationKey] to your router to allow for any [BuildContext] related error displaying.
class GlobalErrorHandler {
  final Map<Type, IAppErrorHandler Function()> controllerHandlers;
  final Future<T?> Function<T>(BuildContext context, OverlayState? overlay, ErrorData errorDetails) showErrorMessage;
  final ErrorData? Function(Object exception) convertException;

  /// Use this navigator key to enable the showing of any build context related error widgets
  late LabeledGlobalKey<NavigatorState> navigationKey;

  GlobalErrorHandler({
    required this.controllerHandlers,
    required this.showErrorMessage,
    required this.convertException,
    LabeledGlobalKey<NavigatorState>? navKey,
  }) {
    navigationKey = navKey ?? LabeledGlobalKey<NavigatorState>('coder_matthews_global_error_handler_navigator_key');
  }
  factory GlobalErrorHandler.withDefaultShowErrorDialog(
          {required Map<Type, IAppErrorHandler Function()> controllerHandlers,
          required ErrorData? Function(Object exception) convertException,
          LabeledGlobalKey<NavigatorState>? navKey}) =>
      GlobalErrorHandler(
          controllerHandlers: controllerHandlers,
          showErrorMessage: showDefaultErrorDialog,
          convertException: convertException);

  /// This function should be called to handle flutter errors
  void handleFlutterError(FlutterErrorDetails details) => _handleError(details.exception, () {
        FlutterError.presentError(details);
      });

  /// This function should be used to handle non flutter errors
  void handleNonFlutterError(Object error, StackTrace trace) => _handleError(error, () {
        throw error;
      });
  void _executeControllerFunction(Type? source) {
    if (source != null) {
      var controller = controllerHandlers[source];
      if (controller != null) {
        controller().onError();
      }
    }
  }

  void _handleError(Object error, void Function() handleDefault) {
    var errorData = convertException.call(error);
    if (errorData == null) {
      handleDefault.call();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (navigationKey.currentContext != null) {
        showErrorMessage(navigationKey.currentContext!, navigationKey.currentState!.overlay, errorData).then((value) {
          _executeControllerFunction(errorData.controllerSource);
        });
      } else {
        debugPrint(
            'It seems that the navigator key for this global error handler is not attached to a navigator, hence why the displaying of errors didn\'t happen');
        debugPrintStack(stackTrace: StackTrace.current);
      }
    });
  }
}
