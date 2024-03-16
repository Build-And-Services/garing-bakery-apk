import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StrukTransactionPage extends StatelessWidget {
  const StrukTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 200,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Gading Bakery",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Address: Jln. Pattimura, Kab. Gresik, Prov. Jawa Timur',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 8.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No Telp: 083853797950',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 8.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No. Faktur: 786324-23423-33434',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            'Tanggal : 786324-23423-33434',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            'Alamat : Jln. Pattimura',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: headerDetailInvoice('Produk'),
                          ),
                          Expanded(
                            flex: 2,
                            child: headerDetailInvoice('Harga'),
                          ),
                          Expanded(
                            flex: 1,
                            child: headerDetailInvoice('QTY'),
                          ),
                          Expanded(
                            flex: 2,
                            child: headerDetailInvoice('Total',
                                align: TextAlign.end),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const ItemDetailWidget(),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          footerDetailInvoice('Total', 60000),
                          footerDetailInvoice('Uang', 100000),
                          footerDetailInvoice('Kembalian', 40000),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerDetailInvoice(String title, {TextAlign? align}) {
    return Container(
      // color: Colors.grey,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: align,
      ),
    );
  }

  Widget footerDetailInvoice(String title, int value) {
    return Container(
      // color: Colors.grey,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Column(
        children: [
          Column(
            children: [
              InvoiceItemWidget(),
              InvoiceItemWidget(),
              InvoiceItemWidget()
            ],
          ),
        ],
      ),
    );
  }
}

class InvoiceItemWidget extends StatelessWidget {
  const InvoiceItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Roti Bolu',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '13000',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '2',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '26000',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
