import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coder_matthews_extensions/coder_matthews_extensions_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCoderMatthewsExtensions platform = MethodChannelCoderMatthewsExtensions();
  const MethodChannel channel = MethodChannel('coder_matthews_extensions');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'isTablet':
            return true;
          default:
            return '42';
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
  test('getIsTablet', () async {
    expect(await platform.isTablet(), true);
  });
}
