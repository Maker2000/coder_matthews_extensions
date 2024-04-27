import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  test('shouldRunFunctionsInParallel', () async {
    Future<List<int>> returnAsyncList(int number) async {
      await Future.delayed(Duration(seconds: 5));
      return [number, number];
    }

    Future<int> returnAsyncNumber(int number) async {
      await Future.delayed(Duration(seconds: 5));
      return number;
    }

    var testNumber = 7;
    var (list, numberRes) =
        await FutureHelper.parallel2(() => returnAsyncList(testNumber), () => returnAsyncNumber(testNumber));
    var controlList = [testNumber, testNumber];
    expect(testNumber, numberRes);
    expect(list, controlList);
    var (list1, numberRes1, numberRes2) = await FutureHelper.parallel3(
      () => returnAsyncList(testNumber),
      () => returnAsyncNumber(5),
      () => returnAsyncNumber(testNumber),
    );
    expect(5, numberRes1);
    expect(testNumber, numberRes2);
    expect(list1, controlList);
  });
  test('shouldCreateCompletedFuture', () async {
    int? nullValue;
    var nonNullValue = 10;
    expect(null, await nullValue.toCompletedFuture());
    expect(10, await nonNullValue.toCompletedFuture());
  });
}
