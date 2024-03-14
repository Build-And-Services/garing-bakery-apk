import 'package:flutter/material.dart';
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

  static alertSucces(BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: message,
      autoCloseDuration: const Duration(seconds: 1),
      showConfirmBtn: false,
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

  static alertWarning(BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: message,
    );
  }

  // final infoAlert = buildButton(
  //   onTap: () {
  //     QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.info,
  //       text: 'Buy two, get one free',
  //     );
  //   },
  //   title: 'Info',
  //   text: 'Buy two, get one free',
  //   leadingImage: 'assets/info.gif',
  // );

  // final confirmAlert = buildButton(
  //   onTap: () {
  //     QuickAlert.show(
  //       onCancelBtnTap: () {
  //         Navigator.pop(context);
  //       },
  //       context: context,
  //       type: QuickAlertType.confirm,
  //       text: 'Do you want to logout',
  //       titleAlignment: TextAlign.right,
  //       textAlignment: TextAlign.right,
  //       confirmBtnText: 'Yes',
  //       cancelBtnText: 'No',
  //       confirmBtnColor: Colors.white,
  //       backgroundColor: Colors.black,
  //       headerBackgroundColor: Colors.grey,
  //       confirmBtnTextStyle: const TextStyle(
  //         color: Colors.black,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       barrierColor: Colors.white,
  //       titleColor: Colors.white,
  //       textColor: Colors.white,
  //     );
  //   },
  //   title: 'Confirm',
  //   text: 'Do you want to logout',
  //   leadingImage: 'assets/confirm.gif',
  // );

  // final loadingAlert = buildButton(
  //   onTap: () {
  //     QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.loading,
  //       title: 'Loading',
  //       text: 'Fetching your data',
  //     );
  //   },
  //   title: 'Loading',
  //   text: 'Fetching your data',
  //   leadingImage: 'assets/loading.gif',
  // );
}

enum TypeStock { decrease, increase }
