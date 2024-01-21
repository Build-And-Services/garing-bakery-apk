import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/widgets/shimmer/wrapper_shimmer_widget.dart';

class CategoryBoxItemShimmer extends StatelessWidget {
  const CategoryBoxItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapperShimmer(
      child: GestureDetector(
        onTap: () {},
        child: Card(
          surfaceTintColor: Colors.amber,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
