import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

Future<T?> showDefaultErrorDialog<T>(BuildContext context, OverlayState? overlay, ErrorData errorData) =>
    showGeneralDialog(
        context: context,
        useRootNavigator: true,
        pageBuilder: (context, animation1, animation2) => DefaultErrorDialog(errorData: errorData));

class DefaultErrorDialog extends StatelessWidget {
  final ErrorData errorData;
  const DefaultErrorDialog({super.key, required this.errorData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(errorData.title),
      content: Text(errorData.message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text('Dismiss'))
      ],
    );
  }
}
