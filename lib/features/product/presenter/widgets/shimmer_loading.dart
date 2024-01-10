import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/product_shimmer_widget.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: 4,
        itemBuilder: (context, _) {
          return const ProductCardShimmer();
        },
      ),
    );
  }
}
