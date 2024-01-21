import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  Widget title;
  Function()? tap;
  ButtonWidget({
    super.key,
    required this.title,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: MyTheme.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
        child: Center(
          child: title,
        ),
      ),
    );
  }
}
