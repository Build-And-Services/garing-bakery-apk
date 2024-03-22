import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
            // width: 250,
            // height: 500,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/data_empty.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              Text(
                'Tidak ada data',
                style: GoogleFonts.poppins(
                  color: MyTheme.brown,
                  fontSize: 16.sp,
                ),
              )
            ]),
      ),
    );
  }
}
