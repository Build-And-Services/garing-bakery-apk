import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:provider/provider.dart';

class DropdownPrint extends StatelessWidget {
  const DropdownPrint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final printProvider = context.watch<PrintProvider>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => printProvider.initBluetooth());

    return StreamBuilder<List<BluetoothDevice>>(
        stream: printProvider.bluetoothPrint.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primary),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    value: printProvider.device?.address == null
                        ? null
                        : !snapshot.data!.any((e) =>
                                e.address == printProvider.device!.address)
                            ? null
                            : printProvider.device?.address,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e.address,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.name ?? 'No name device'),
                                  Text(e.address ?? 'No address device'),
                                ],
                              ),
                              onTap: () {
                                printProvider.setDevice = e;
                                // if (printProvider.device != null) {
                                //   printProvider.bluetoothPrint.connect(e);
                                // }
                              },
                            ))
                        .toList(),
                    onChanged: (value) {},
                  )),
            ),
          );
        });
  }
}
