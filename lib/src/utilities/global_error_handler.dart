import 'package:flutter/material.dart';

import '../exceptions/exceptions.dart';
import '../helpers/helpers.dart';
import '../widgets/widgets.dart';

/// Implement this interface to allow for error handling controllers.
abstract interface class IAppErrorHandler {
  void onError(Object exception);
}

/// A [GlobalErrorHandler] to ahndle uncaught errors globally. The [handleException] function should be used to check the exception and return a
/// nullable [T] that extends the [ErrorData] object.
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
///
/// This class makes use of a new exception [ControllerException] which can be extended. The [Type] source is required.
/// Example exception class:
/// ```dart
/// class AppException extends ControllerException {
///  final Type innerSource;
///
///  AppException(this.innerSource);
///  @override
///  String get message => 'You are not authorized to access the resources you requested.';
///
///  @override
///  Type get source => innerSource;
///
///  @override
///  String get title => 'App Error';
/// }
/// ```
class GlobalErrorHandler<T extends ErrorData> {
  /// Represents the collection of controller handlers that will extend [IAppErrorHandler] in order to
  /// handle the errors globally. Useful when using providers in your application for state management
  ///
  /// Example using riverpod:
  /// ```dart
  /// class ExampleNotifier extends AsyncNotifier<ExampleState> implements IErrorHandler {...}
  /// ```
  final Map<Type, IAppErrorHandler Function()> controllerHandlers;

  /// Represends the widget (normally an alert dialog) that displays the error when an exeption happens.
  /// One can use an overlay widget to show the error as well.
  final Future<void> Function(BuildContext context, OverlayState? overlay, T errorDetails) showErrorMessage;

  /// This function parameter accepts an [Object] exception and converts the data to an [ErrorData] object,
  ///
  /// Simplified Example:
  /// ```dart
  /// convertException: (error) {
  ///     if (error is Exception) {
  ///        return ErrorData(message: error.toString(), title: 'Error', exception: error);
  ///     }
  ///     if (error is ControllerException)
  ///     {
  ///       return ErrorData(message: error.message, title: error.title, exception: error);
  ///     }
  ///     return null;
  ///  }
  /// ```
  final T? Function(Object exception) handleException;

  /// This is useful when initialising async riverpod providers. Should return an error widget when an error occurs during
  /// riverpod provider initialization
  /// related to the available [handleInitRiverpodProviderError] function.
  final Widget? Function(BuildContext context, T data) riverpodErrorWidget;

  /// Use this navigator key to enable the showing of any build context related error widgets
  late LabeledGlobalKey<NavigatorState> navigationKey;

  /// Creates a [GlobalErrorHandler] object.
  GlobalErrorHandler({
    required this.controllerHandlers,
    required this.showErrorMessage,
    required this.handleException,
    required this.riverpodErrorWidget,
    LabeledGlobalKey<NavigatorState>? navKey,
  }) {
    navigationKey = navKey ?? LabeledGlobalKey<NavigatorState>('coder_matthews_global_error_handler_navigator_key');
  }

  /// Sets uo a [GlobalErrorHandler] with a simple alert dialog when errors occur, It is recommend that you use
  /// the regular [GlobalErrorHandler] constructor for more customization.
  factory GlobalErrorHandler.withDefaultShowErrorDialog(
          {required Map<Type, IAppErrorHandler Function()> controllerHandlers,
          required T? Function(Object exception) handleException,
          required Widget? Function(BuildContext context, T data) riverpodErrorWidget,
          LabeledGlobalKey<NavigatorState>? navKey}) =>
      GlobalErrorHandler(
          controllerHandlers: controllerHandlers,
          showErrorMessage: showDefaultErrorDialog,
          riverpodErrorWidget: riverpodErrorWidget,
          handleException: handleException);

  /// This function should be called to handle flutter errors
  void handleFlutterError(FlutterErrorDetails details) => _handleError(details.exception, () {
        FlutterError.presentError(details);
      });

  /// This function should be used to handle non flutter errors
  void handleNonFlutterError(Object error, StackTrace trace) => _handleError(error, () {
        throw error;
      });

  void _executeControllerFunction(T errorData) {
    if (errorData.controllerSource != null) {
      var controller = controllerHandlers[errorData.controllerSource!];
      if (controller != null) {
        controller().onError(errorData.exception);
      }
    }
    // errorData.actions.firstOrNull?.op();
  }

  void _handleError(Object error, void Function() handleDefault) {
    var errorData = handleException.call(error);
    if (errorData == null) {
      handleDefault.call();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (navigationKey.currentContext != null) {
        showErrorMessage(navigationKey.currentContext!, navigationKey.currentState!.overlay, errorData).then((value) {
          _executeControllerFunction(errorData);
        });
      } else {
        _executeControllerFunction(errorData);
        debugPrint(
            'It seems that the navigator key for this global error handler is not attached to a navigator, hence why the displaying of errors didn\'t happen');
        debugPrintStack(stackTrace: StackTrace.current);
      }
    });
  }

  /// Use this function if you're using riverpod and handling errors when initializing the provider.
  ///
  /// ie:
  /// ```dart
  /// provider.when(...)
  /// ```
  ///
  /// Throws the exception if the exception is not handled in [handleException]
  Widget? handleInitRiverpodProviderError(BuildContext context, Object error, StackTrace trace) {
    var data = handleException(error);
    if (data == null) throw error;
    return riverpodErrorWidget(context, data);
  }
}
