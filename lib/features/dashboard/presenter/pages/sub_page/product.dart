import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/dashboard/presenter/widgets/drawer_widget.dart';

class ProductSubPage extends StatelessWidget {
  const ProductSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          'Produk / Barang',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.primary,
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const SearchWidget(),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView(
                  children: const [
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(50, 0, 0, 0),
              offset: Offset(6, 4),
              blurRadius: 10,
            )
          ],
          border: Border.all(
            color: const Color.fromARGB(77, 95, 95, 95),
            width: 1,
            style: BorderStyle.solid,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bakery Roti",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "4385",
                      style: TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "100",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      Text("Rp. 20.000"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            // width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search roti",
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
            ),
          ),
        ],
      ),
    );
  }
}
