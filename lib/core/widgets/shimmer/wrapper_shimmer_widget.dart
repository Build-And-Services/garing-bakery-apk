import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WrapperShimmer extends StatelessWidget {
  final Widget child;
  const WrapperShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: child,
    );
  }
}
