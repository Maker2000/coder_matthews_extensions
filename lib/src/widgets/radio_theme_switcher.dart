import 'custom_bottom_sheet.dart';

import '../extensions/string_extensions.dart';
import 'package:flutter/material.dart';

Map<ThemeMode, IconData> get themeIconDictionary =>
    {ThemeMode.dark: Icons.dark_mode, ThemeMode.light: Icons.sunny, ThemeMode.system: Icons.contrast};

class RadioThemeSwitcher extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final void Function(ThemeMode mode) onTap;
  const RadioThemeSwitcher({super.key, required this.currentThemeMode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var mode in ThemeMode.values)
          RadioListTile.adaptive(
              secondary: Icon(themeIconDictionary[mode]),
              title: Text('${mode.name.titleCase} Mode'),
              value: mode,
              groupValue: currentThemeMode,
              onChanged: (mode) {
                onTap(mode ?? ThemeMode.system);
                Navigator.of(context, rootNavigator: true).pop();
              })
      ],
    );
  }
}

Future<T?> showBottomSheetThemeSwitcher<T>(
        BuildContext context, ThemeMode currentThemeMode, void Function(ThemeMode mode) onTap) =>
    showCustomBottomSheet(context, RadioThemeSwitcher(onTap: onTap, currentThemeMode: currentThemeMode));
