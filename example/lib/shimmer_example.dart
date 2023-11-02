import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:flutter/material.dart';

class ShimmerExample extends StatelessWidget {
  const ShimmerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.create(
      brightness: Theme.of(context).brightness,
      child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: RepeatShimmerItem(repeatCount: 20, items: [
              ShimmerContainer(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ShimmerItem(height: 16, width: 90),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ShimmerItem(height: 16, width: 50),
                      ],
                    ),
                  ],
                ),
              )),
              SizedBox(height: 10),
            ]),
          )),
    );
  }
}
