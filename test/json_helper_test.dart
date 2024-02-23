import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    JsonHelper.instance.addSerializer(
        JsonSerializerItem<CoderPerson>(decode: (data) => CoderPerson.decode(data), encode: (data) => data.toJson()));
  });
  test("shouldEncodeJson", () {
    var data = {'name': "John Doe", 'age': 14, 'gender': 'male'};
    var decodedData = CoderPerson(name: 'John Doe', age: 14, gender: Gender.male);
    var testDecodedPerson = JsonHelper.instance.decodeWithType(CoderPerson, data);
    var encodedPerson = JsonHelper.instance.encodeWithType(CoderPerson, decodedData);
    expect(testDecodedPerson?.age, decodedData.age);
    expect(data, encodedPerson);
  });
}
