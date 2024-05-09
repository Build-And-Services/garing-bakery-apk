import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyTheme {
  static const Color primary = Colors.brown;
  static const Color secondary = Color.fromARGB(255, 31, 132, 13);
  static const Color white = Colors.white;
  static const Color brown = Colors.brown;

  static AppBar appBar(String title, List<Widget>? action) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: MyTheme.primary,
      actions: action,
    );
  }

  static AppBar secondaryAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: MyTheme.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: MyTheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static alertSucces(BuildContext context, String message,
      {bool confirm = false, Duration? duration = const Duration(seconds: 1)}) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: message,
      autoCloseDuration: duration,
      showConfirmBtn: confirm,
    );
  }

  static alertError(BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
      backgroundColor: Colors.black,
      titleColor: Colors.white,
      textColor: Colors.white,
    );
  }

  static alertWarning(
    BuildContext context,
    String message, {
    bool showCancelBtn = false,
    Function()? onConfirmBtnTap,
  }) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: message,
      confirmBtnColor: primary,
      showCancelBtn: showCancelBtn,
      onConfirmBtnTap: onConfirmBtnTap,
    );
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static showSnackBarFun(context, String message, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150,
        left: 10,
        right: 10,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<bool> showDialogClose(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Close The App'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to close the application?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            const SizedBox(width: 10),
            FilledButton(
              child: const Text('Close App'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

enum TypeStock { decrease, increase }
