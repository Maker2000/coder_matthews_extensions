// ignore_for_file: library_private_types_in_public_api

import 'package:coder_matthews_extensions/src/extensions/extensions.dart';
import 'package:flutter/material.dart';

LinearGradient shimmerGradient(Brightness brightness) => LinearGradient(
      colors: [
        brightness.isLight ? const Color.fromARGB(255, 214, 217, 221) : const Color(0xFF2A2A2A),
        brightness.isLight ? const Color.fromARGB(255, 233, 235, 238) : const Color(0xFF4C4C4C),
        brightness.isLight ? const Color.fromARGB(255, 214, 217, 221) : const Color(0xFF2A2A2A)
      ],
      stops: const [
        0.1,
        0.3,
        0.5,
      ],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    //if (widget.isLoading) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (!widget.isLoading) {
    //   return widget.child;
    // }

    // Collect ancestor shimmer information.
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.linearGradient, this.child});
  final LinearGradient linearGradient;
  final Widget? child;
  static _ShimmerState? of(BuildContext context) => context.findAncestorStateOfType<_ShimmerState>();
  Shimmer.create({Key? key, required Brightness brightness, this.child})
      : linearGradient = shimmerGradient(brightness),
        super(key: key);
  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  Gradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );
  Listenable get shimmerChanges => _shimmerController;

  bool get isSized => (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(child: widget.child ?? const SizedBox.shrink());
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerContainer extends StatelessWidget {
  final Widget child;
  const ShimmerContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor.withAlpha(150),
      child: child,
    );
  }
}

class ShimmerItem extends StatelessWidget {
  final double height, width, borderRadius;
  const ShimmerItem({super.key, required this.height, required this.width, this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration:
            BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: SizedBox(
          height: height,
          width: width,
        ));
  }
}

class RepeatShimmerItem extends StatelessWidget {
  final int repeatCount;
  final List<Widget> items;
  const RepeatShimmerItem({super.key, required this.repeatCount, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(repeatCount, (index) => items).expand((element) => element).toList(),
    );
  }
}
