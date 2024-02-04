import 'enums.dart';

class MultiSorterArgs<T> {
  final T? field;
  final OrderDirection orderDirection;

  MultiSorterArgs({required this.field, this.orderDirection = OrderDirection.asc});
}

/// Represents the data used in the [GlobalErrorHandler]'s
abstract class ErrorData {
  final String message;
  final String title;
  final Object exception;
  final Type? controllerSource;
  final void Function()? onError;
  ErrorData({required this.message, required this.title, required this.exception, this.controllerSource, this.onError});
}
