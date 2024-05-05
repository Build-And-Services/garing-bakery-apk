import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/core/routes/app.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          top: height / 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileArea(),
            const SizedBox(
              height: 50,
            ),
            _tapSidebar(
              Icons.dataset_rounded,
              "Dashboard",
              () => Navigator.pushReplacementNamed(
                context,
                Routes.DASHBOARD,
              ),
            ),
            _tapSidebar(
              Icons.print_outlined,
              "Printer dan struk",
              () => Navigator.pushReplacementNamed(
                context,
                Routes.STRUCK_SETTING,
              ),
            ),
            _tapSidebar(
              Icons.note_outlined,
              "Laporan",
              () => Navigator.pushReplacementNamed(
                context,
                Routes.REPORTS,
              ),
            ),
            _tapSidebar(Icons.logout_outlined, "Logout", () {
              TokenService.logout().then(
                (value) => Navigator.pushReplacementNamed(
                  context,
                  Routes.LOGIN,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  InkWell _tapSidebar(IconData icon, String label, Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.all(
          10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: MyTheme.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder _profileArea() {
    return FutureBuilder(
        future: TokenService.getCacheUser(),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return Container();
          }
          if (snapshot.data == null) {
            return Container();
          }

          UserModel dataUser = snapshot.data;
          return Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: MyTheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      100,
                    ),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(dataUser.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataUser.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    dataUser.role,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              )
            ],
          );
        });
  }
}
