import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Colors.brown;
  static const Color secondary = Color.fromARGB(255, 31, 132, 13);
  static const Color white = Colors.white;
  static const Color brown = Colors.brown;

  static AppBar appBar(String title, List<Widget>? action) {
    return AppBar(
      // leading: IconButton(
      //   icon: const Icon(Icons.format_align_left_outlined),
      //   onPressed: () => Scaffold.of(context).openDrawer(),
      // ),
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
}
