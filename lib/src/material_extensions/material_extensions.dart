import 'package:coder_matthews_extensions/src/material_extensions/helper_classes.dart';
import 'package:flutter/material.dart';

extension GlobalKeyExn on GlobalKey {
  ///Gets the [RelativeRect] and [RenderBox] in a nullable [PositionData] object on the widget attached to a given [GlobalKey]
  PositionData? getKeyPosition(BuildContext context) {
    var button = currentContext?.findRenderObject() as RenderBox?;
    if (button == null) return null;
    var overlay = Overlay.maybeOf(context, rootOverlay: true)?.context.findRenderObject() as RenderBox?;
    if (overlay == null) return null;
    return PositionData(
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
