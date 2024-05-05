import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSubPage extends StatefulWidget {
  const ProfileSubPage({super.key});

  @override
  State<ProfileSubPage> createState() => _ProfileSubPageState();
}

class _ProfileSubPageState extends State<ProfileSubPage> {
  UserModel? user;

  Future getStringValuesSF() async {
    UserModel userCache = await TokenService.getCacheUser();
    setState(() {
      user = userCache;
    });
  }

  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (user == null) {
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
            _headerProfile(width, height, user!),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _tileInformation(
                    Icons.email,
                    "Email",
                    user!.email,
                  ),
                  _tileInformation(
                    Icons.person,
                    "Role",
                    "${user!.email} store",
                  ),
                  _tileInformation(
                    Icons.email,
                    "Password",
                    "***************",
                  ),
                  _tileInformation(
                    Icons.email,
                    "Token Login",
                    "&65jhjgwuegr37uyggbfuegwruyegr",
                  ),
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
      width: width / 3,
      height: width / 3,
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
