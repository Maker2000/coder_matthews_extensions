import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  test("shouldConvertToTitle", () {
    var testingEnum = TestingEnum.longTitle;
    var control = 'Long Title';
    expect(control, testingEnum.titleCase);
  });
}
