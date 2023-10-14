class FutureHelper {
  /// Executes 2 functions in parallel using Future.wait, and returns their results as tuples
  static Future<(F1, F2)> parallel2<F1, F2>(Future<F1> Function() f1, Future<F2> Function() f2) async {
    var res = await Future.wait([f1.call(), f2.call()]);
    return (res.whereType<F1>().first, res.skip(1).whereType<F2>().first);
  }

  /// Executes 3 functions in parallel using Future.wait, and returns their results as tuples
  static Future<(F1, F2, F3)> parallel3<F1, F2, F3>(
      Future<F1> Function() f1, Future<F2> Function() f2, Future<F3> Function() f3) async {
    var res = await Future.wait([f1.call(), f2.call(), f3.call()]);
    return (res.whereType<F1>().first, res.skip(1).whereType<F2>().first, res.skip(2).whereType<F3>().first);
  }

  /// Executes 4 functions in parallel using Future.wait, and returns their results as tuples
  static Future<(F1, F2, F3, F4)> parallel4<F1, F2, F3, F4>(
    Future<F1> Function() f1,
    Future<F2> Function() f2,
    Future<F3> Function() f3,
    Future<F4> Function() f4,
  ) async {
    var res = await Future.wait([f1.call(), f2.call(), f3.call(), f4.call()]);
    return (
      res.whereType<F1>().first,
      res.skip(1).whereType<F2>().first,
      res.skip(2).whereType<F3>().first,
      res.skip(3).whereType<F4>().first
    );
  }

  /// Executes 5 functions in parallel using Future.wait, and returns their results as tuples
  static Future<(F1, F2, F3, F4, F5)> parallel5<F1, F2, F3, F4, F5>(
    Future<F1> Function() f1,
    Future<F2> Function() f2,
    Future<F3> Function() f3,
    Future<F4> Function() f4,
    Future<F5> Function() f5,
  ) async {
    var res = await Future.wait([f1.call(), f2.call(), f3.call(), f4.call(), f5.call()]);
    return (
      res.whereType<F1>().first,
      res.skip(1).whereType<F2>().first,
      res.skip(2).whereType<F3>().first,
      res.skip(3).whereType<F4>().first,
      res.skip(4).whereType<F5>().first
    );
  }

  /// Executes 6 functions in parallel using Future.wait, and returns their results as tuples
  static Future<(F1, F2, F3, F4, F5, F6)> parallel6<F1, F2, F3, F4, F5, F6>(
      Future<F1> Function() f1,
      Future<F2> Function() f2,
      Future<F3> Function() f3,
      Future<F4> Function() f4,
      Future<F5> Function() f5,
      Future<F6> Function() f6) async {
    var res = await Future.wait([
      f1.call(),
      f2.call(),
      f3.call(),
      f4.call(),
      f5.call(),
      f6.call(),
    ]);
    return (
      res.whereType<F1>().first,
      res.skip(1).whereType<F2>().first,
      res.skip(2).whereType<F3>().first,
      res.skip(3).whereType<F4>().first,
      res.skip(4).whereType<F5>().first,
      res.skip(5).whereType<F6>().first,
    );
  }
}
