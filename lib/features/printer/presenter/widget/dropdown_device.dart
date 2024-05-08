import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/features/transaction/presenter/provider/print_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme.dart';

class DropdownDevice extends StatelessWidget {
  const DropdownDevice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final printProvider = context.watch<PrintProvider>();
    if (printProvider.devices.isEmpty) {
      printProvider.getDevices();
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: MyTheme.primary,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            borderRadius: BorderRadius.circular(8),
            itemHeight: 60,
            alignment: Alignment.center,
            value: printProvider.device,
            items: printProvider.devices
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
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
                    },
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
