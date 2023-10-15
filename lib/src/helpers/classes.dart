import 'enums.dart';

class MultiSorterArgs<T> {
  final T? field;
  final OrderDirection orderDirection;

  MultiSorterArgs({required this.field, this.orderDirection = OrderDirection.asc});
}
