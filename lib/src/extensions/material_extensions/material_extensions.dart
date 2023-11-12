import 'package:flutter/material.dart';

import 'helper_classes.dart';
export 'helper_classes.dart';

extension GlobalKeyExn on GlobalKey {
  ///Gets the [RelativeRect] and [RenderBox] in a nullable [WidgetPositionData] object on the widget attached to a given [GlobalKey]
  WidgetPositionData? getKeyPosition(BuildContext context) {
    var button = currentContext?.findRenderObject() as RenderBox?;
    if (button == null) return null;
    var overlay = Overlay.maybeOf(context, rootOverlay: true)?.context.findRenderObject() as RenderBox?;
    if (overlay == null) return null;
    return WidgetPositionData(
      RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(button.size.topLeft(Offset.zero), ancestor: overlay),
          button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      ),
      button,
    );
  }
}

extension BrightnessExt on Brightness {
  bool get isLight => this == Brightness.light;
  bool get isDark => this == Brightness.dark;
}
