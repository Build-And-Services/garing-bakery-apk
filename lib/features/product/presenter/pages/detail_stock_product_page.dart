import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/core/widgets/no_data_widget.dart';
import 'package:garing_bakery_apk/features/product/data/model/response_product.dart';
import 'package:garing_bakery_apk/features/product/data/service/product_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailStockProductPage extends StatefulWidget {
  final String id;

  const DetailStockProductPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailStockProductPage> createState() => _DetailStockProductPageState();
}

class _DetailStockProductPageState extends State<DetailStockProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          'Detail Stock Barang',
          style: TextStyle(
            color: MyTheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<StockProductResponse?>(
            future: ProductService.getStockProduct(widget.id),
            builder: (context, snapshot) {
              if (ConnectionState.waiting == snapshot.connectionState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.brown,
                    ),
                  ),
                );
              }
              final StockProductResponse? stockData = snapshot.data;
              if (stockData == null) {
                return const NoDataWidget();
              }

              return Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stockData.product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      stockData.product.productCode,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: MyTheme.brown,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        color: const Color.fromARGB(255, 244, 232, 227),
                      ),
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Harga Dasar Terakhir",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                formatRupiah(stockData.totalResidual),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "* Harga ini diambil dari total stok terakhir",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 79, 79, 79),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Total Stok: ${stockData.totalQuantity}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: MyTheme.brown,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: MyTheme.brown,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        color: const Color.fromARGB(255, 244, 232, 227),
                      ),
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            "Penjualan berikutnya",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            formatRupiah(stockData.totalQuantity *
                                stockData.product.sellingPrice),
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: stockData.stock
                          .map(
                            (e) => ListTileStock(
                              tanggal: e.createdAt,
                              stock: e.quantity,
                              type: e.type,
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ListTileStock extends StatelessWidget {
  const ListTileStock({
    super.key,
    required this.tanggal,
    required this.stock,
    required this.type,
  });
  final DateTime tanggal;
  final int stock;
  final String type;

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.parse(tanggal);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Masuk",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  DateFormat('HH:mm dd MMM yyyy').format(tanggal),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Stock",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  stock.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Type",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  type == "increase" ? "Stok Masuk" : "Stock Keluar",
                  style: GoogleFonts.poppins(
                    color: type == "increase" ? Colors.green : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
