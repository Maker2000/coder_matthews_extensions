import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'coder_matthews_extensions_method_channel.dart';

abstract class CoderMatthewsExtensionsPlatform extends PlatformInterface {
  /// Constructs a CoderMatthewsExtensionsPlatform.
  CoderMatthewsExtensionsPlatform() : super(token: _token);

  static final Object _token = Object();

  static CoderMatthewsExtensionsPlatform _instance = MethodChannelCoderMatthewsExtensions();

  /// The default instance of [CoderMatthewsExtensionsPlatform] to use.
  ///
  /// Defaults to [MethodChannelCoderMatthewsExtensions].
  static CoderMatthewsExtensionsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CoderMatthewsExtensionsPlatform] when
  /// they register themselves.
  static set instance(CoderMatthewsExtensionsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> isTablet();
}
