import 'dart:io';

import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  test(
    'shouldShowFilesizeDescription',
    () async {
      var file = File('${Directory.current.path}/test/test_file.txt');
      var size = await file.fileSizeDescription();
      expect(size, '445 b');
    },
  );
  test(
    'shouldGetFileSizeInKiloBytes',
    () async {
      var file = File('${Directory.current.path}/test/test_file.txt');
      var size = await file.sizeInKb;
      expect(size, 0.4345703125);
    },
  );
}
