/// Support for doing something awesome.
///
/// More dartdocs go here.
library coder_matthews_extensions;

import 'package:coder_matthews_extensions/coder_matthews_extensions_platform_interface.dart';

export 'src/extensions/coder_matthews_extensions_base.dart';
export 'src/extensions/string_extensions.dart';
export 'src/extensions/date_extensions.dart';
export 'src/extensions/list_extensions.dart';
export 'src/extensions/map_extensions.dart';
export 'src/extensions/enum_extensions.dart';
export 'src/helpers/validation_contract.dart';
export 'src/exceptions/exceptions.dart';
export 'src/extensions/object_extensions.dart';
export 'src/extensions/material_extensions/material_extensions.dart';
export 'src/helpers/future_helper.dart';
export 'src/helpers/enums.dart';

class CoderMatthewsExtensions {
  /// Returns the playform version
  Future<String?> getPlatformVersion() => CoderMatthewsExtensionsPlatform.instance.getPlatformVersion();

  /// Returns whether the current device is a tablet or not
  static Future<bool> isTablet() => CoderMatthewsExtensionsPlatform.instance.isTablet();
}

class TabletExtensions {
  /// Returns whether the current device is a tablet or not
  static Future<bool> isTablet() => CoderMatthewsExtensionsPlatform.instance.isTablet();
}
