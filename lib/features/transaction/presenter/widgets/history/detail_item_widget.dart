import "package:flutter/material.dart";
import "package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart";
import "package:garing_bakery_apk/features/transaction/presenter/widgets/invoice_item_widget.dart";

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    super.key,
    required this.detail,
  });
  final List<DetailTransactionsResponse> detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            children: detail
                .map((product) => InvoiceItemWidget(product: product))
                .toList(),
          ),
        ],
      ),
    );
  }
}
