import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'coder_matthews_extensions_platform_interface.dart';

/// An implementation of [CoderMatthewsExtensionsPlatform] that uses method channels.
class MethodChannelCoderMatthewsExtensions extends CoderMatthewsExtensionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('coder_matthews_extensions');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> isTablet() async {
    try {
      var res = await methodChannel.invokeMethod<bool>('isTablet');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }
}
