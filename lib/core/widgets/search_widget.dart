import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.notifications_outlined,
              color: MyTheme.primary,
            ),
          ),
          const Expanded(
            // width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1,
                ),
                hintText: "cari nama atau kode dari barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.filter_list_rounded,
              color: MyTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
