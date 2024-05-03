import 'enums.dart';

class MultiSorterArgs<T> {
  final T? field;
  final OrderDirection orderDirection;

  MultiSorterArgs({required this.field, this.orderDirection = OrderDirection.asc});
}

/// Represents the data used in the [GlobalErrorHandler]'s
///
/// You may use [ErrorDataAction.defaultAction] to set the [onError] property
abstract class ErrorData {
  final String message;
  final String title;
  final Object exception;
  final List<ErrorDataAction> actions;
  final Type? controllerSource;
  ErrorData({
    required this.message,
    required this.title,
    required this.exception,
    this.controllerSource,
    this.actions = const [],
  });
}

class ErrorDataAction {
  final String title;
  final void Function() op;

  ErrorDataAction({required this.title, required this.op});
  ErrorDataAction.defaultAction({required this.op}) : title = 'OK';
}
