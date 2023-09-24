/// Support for doing something awesome.
///
/// More dartdocs go here.
library coder_matthews_extensions;

import 'package:coder_matthews_extensions/coder_matthews_extensions_platform_interface.dart';

export 'src/coder_matthews_extensions_base.dart';
export 'src/string_extensions.dart';
export 'src/date_extensions.dart';
export 'src/list_extensions.dart';
export 'src/map_extensions.dart';
export 'src/enum_extensions.dart';
export 'src/validation_contract.dart';
export 'src/exceptions/exceptions.dart';
export 'src/object_extensions.dart';
export 'src/material_extensions/material_extensions.dart';

class CoderMatthewsExtensions {
  /// Returns the playform version
  Future<String?> getPlatformVersion() => CoderMatthewsExtensionsPlatform.instance.getPlatformVersion();

  /// Returns whether the current device is a tablet or not
  static Future<bool> isTablet() => CoderMatthewsExtensionsPlatform.instance.isTablet();
}
