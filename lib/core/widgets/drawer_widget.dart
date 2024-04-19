import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
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
            _tapSidebar(Icons.print_outlined, "Printer dan struk", () {}),
            // _tapSidebar(Icons.money_sharp, "Keuangan", () {}),
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

  GestureDetector _tapSidebar(IconData icon, String label, Function() ontap) {
    return GestureDetector(
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

  Row _profileArea() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(
                100,
              ),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              size: 50,
              color: Color.fromARGB(255, 71, 31, 17),
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
              'Heri Setyawan',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              'Cashier Store',
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
  }
}
