import 'package:coder_matthews_extensions/coder_matthews_extensions_platform_interface.dart';

export 'src/exceptions/exceptions.dart';
export 'src/extensions/extensions.dart';
export 'src/helpers/helpers.dart';
export 'src/widgets/widgets.dart';
export 'src/utilities/utilities.dart';

class CoderMatthewsExtensions {
  /// Returns the playform version
  Future<String?> getPlatformVersion() => CoderMatthewsExtensionsPlatform.instance.getPlatformVersion();
}

class TabletExtensions {
  /// Returns whether the current device is a tablet or not
  static Future<bool> isTablet() => CoderMatthewsExtensionsPlatform.instance.isTablet();
}
