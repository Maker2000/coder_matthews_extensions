import 'package:coder_matthews_extensions_example/shimmer_example.dart';
import 'package:coder_matthews_extensions_example/widget_position_example.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

final globalErrorHandler = GlobalErrorHandler.withDefaultShowErrorDialog(
    controllerHandlers: {},
    convertException: (error) {
      if (error is Exception) return ErrorData(message: error.toString(), title: 'Error', exception: error);
      if (error is ControllerException) return ErrorData(message: error.message, title: error.title, exception: error);
      return null;
    });
void main() {
  runZonedGuarded(() {
    FlutterError.onError = (details) {
      globalErrorHandler.handleFlutterError(details);
    };
    runApp(const MyApp());
  }, (error, stack) {
    globalErrorHandler.handleNonFlutterError(error, stack);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalErrorHandler.navigationKey,
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/widget_position_example": (context) => const WidgetPositionExample(),
        "/shimmer_example": (context) => const ShimmerExample(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _platformVersion = 'Unknown';
  bool isTablet = false;
  final _coderMatthewsExtensionsPlugin = CoderMatthewsExtensions();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _coderMatthewsExtensionsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    isTablet = await TabletExtensions.isTablet();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Map<String, String> get otherExamples => {
        '/widget_position_example': 'Widget Position Example',
        '/shimmer_example': 'Shimmer Loading Example',
      };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Running on: $_platformVersion\n'),
            Text(isTablet ? 'This device is a tablet' : 'This device is phone'),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Other Examples'),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var item in otherExamples.entries)
                                  ElevatedButton(
                                      onPressed: () => Navigator.of(context).pushNamed(item.key),
                                      child: Text(item.value))
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Text('Other Examples')),
            ElevatedButton(
                onPressed: () {
                  throw ApiServerErrorException(innerSource: String);
                },
                child: const Text('Test Global Exception Handler'))
          ],
        ),
      ),
    );
  }
}
