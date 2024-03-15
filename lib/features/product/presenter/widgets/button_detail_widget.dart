import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonDetailWidget extends StatelessWidget {
  const ButtonDetailWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyTheme.brown,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: MyTheme.brown,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              icon,
              color: MyTheme.brown,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
