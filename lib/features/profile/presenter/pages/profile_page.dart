import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/profile/presenter/provider/form_profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSubPage extends StatelessWidget {
  const ProfileSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dataProfile = context.watch<FormProfileProvider>();
    if (dataProfile.userProfile == null || dataProfile.token == null) {
      dataProfile.getDataProfile();
      dataProfile.getToken();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _headerProfile(width, height, dataProfile.userProfile!),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _tileInformation(
                    Icons.email,
                    "Email",
                    dataProfile.userProfile!.email,
                  ),
                  _tileInformation(
                    Icons.person,
                    "Role",
                    dataProfile.userProfile!.role,
                  ),
                  _tileInformation(
                    Icons.email,
                    "Password",
                    "***************",
                  ),
                  _tileInformation(Icons.email, "Token Login",
                      "${dataProfile.token!.substring(0, 20)}***"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.UPDATE_PROFILE,
                        arguments: dataProfile.userProfile!.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      width: width,
                      decoration: const BoxDecoration(
                        color: MyTheme.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Update data",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _tileInformation(IconData icon, String label, String info) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(
        10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                info,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color.fromARGB(
                    255,
                    73,
                    73,
                    73,
                  ),
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _headerProfile(double width, double height, UserModel user) {
    return Container(
      width: width,
      height: height * 4.5 / 10,
      decoration: const BoxDecoration(
        color: MyTheme.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            30,
          ),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _bigBall(width),
          _smallBall(width),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _contentProfile(width, user),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "${user.role} store",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Positioned _smallBall(double width) {
    return Positioned(
      width: width * 2,
      height: width * 2,
      top: -width / 0.9,
      right: -width / 0.7,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.transparent,
              Color.fromARGB(54, 255, 255, 255),
            ],
            stops: [0.2, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: MyTheme.primary,
              offset: Offset(
                10,
                -10,
              ),
              blurRadius: 10,
            )
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _bigBall(double width) {
    return Positioned(
      width: width * 2,
      height: width * 2,
      top: -width,
      right: -width,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.transparent,
              Color.fromARGB(54, 255, 255, 255),
            ],
            stops: [0.2, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: MyTheme.primary,
              offset: Offset(
                10,
                -10,
              ),
              blurRadius: 10,
            )
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Container _contentProfile(double width, UserModel user) {
    return Container(
      width: width < 480 ? width / 3 : width / 6,
      height: width < 480 ? width / 3 : width / 6,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 10,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        image: DecorationImage(
          image: NetworkImage(user.image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
