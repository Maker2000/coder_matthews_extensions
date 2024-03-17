import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ColorExn on Color {
  /// Returns a new color with the [saturation] set. The [saturation] is a [double] that goes from 0 to 1
  Color withSaturation(double saturation) =>
      HSVColor.fromColor(this).withSaturation(clampDouble(saturation, 0, 1)).toColor();

  /// Returns a new color with the [value] set. The [value] is a [double] that goes from 0 to 1
  Color withValue(double value) => HSVColor.fromColor(this).withValue(clampDouble(value, 0, 1)).toColor();

  /// Returns a new color with the [hue] set. The [hue] is a [double] that goes from 0 to 360
  Color withHue(double hue) => HSVColor.fromColor(this).withHue(clampDouble(hue, 0, 360)).toColor();
}
