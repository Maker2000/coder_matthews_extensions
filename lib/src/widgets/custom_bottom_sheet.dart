import 'package:flutter/material.dart';

Future<T?> showCustomBottomSheet<T>(BuildContext context, Widget child, {Widget? title}) => showModalBottomSheet(
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => CustomBottomSheet(
          title: title,
          child: child,
        ));

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  final Widget? title;

  const CustomBottomSheet({super.key, required this.child, this.title});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 5,
                        width: 55,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      if (widget.title != null) ...[
                        const SizedBox(
                          height: 17,
                        ),
                        DefaultTextStyle.merge(child: widget.title!, style: Theme.of(context).textTheme.titleLarge),
                      ],
                      Flexible(
                        child: SingleChildScrollView(
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
