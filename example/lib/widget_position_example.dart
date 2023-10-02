import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:flutter/material.dart';

class WidgetPositionExample extends StatefulWidget {
  const WidgetPositionExample({super.key});

  @override
  State<WidgetPositionExample> createState() => _WidgetPositionExampleState();
}

class _WidgetPositionExampleState extends State<WidgetPositionExample> {
  final widgetKey = LabeledGlobalKey('widgetKey');
  String widgetPosition = '-';

  void _getWidgetPositionData() {
    var data = widgetKey.getKeyPosition(context);
    if (data != null) {
      widgetPosition =
          'left: ${data.relativeRect.left}, top: ${data.relativeRect.top}, right: ${data.relativeRect.right}, bottom: ${data.relativeRect.bottom},';
    } else {
      widgetPosition = 'Null position';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Position Example')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.person,
            key: widgetKey,
          ),
          Text('Icon widget position: $widgetPosition'),
          ElevatedButton(onPressed: _getWidgetPositionData, child: const Text('Get Icon Position'))
        ]),
      ),
    );
  }
}
