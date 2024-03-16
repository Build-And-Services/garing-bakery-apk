import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/features/reports/presenter/provider/reports_sales_provider.dart';
import 'package:provider/provider.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ReportsSalesProvider reportsSalesProvider =
        context.watch<ReportsSalesProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyTheme.primary)),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              borderRadius: BorderRadius.circular(8),
              value: reportsSalesProvider.dropdownValue,
              items: reportsSalesProvider.filter.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(items),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue == 'Yesterday') {
                  reportsSalesProvider.dateTime =
                      DateTime.now().subtract(const Duration(days: 1));
                  reportsSalesProvider.dropdownValue = 'Yesterday';
                } else if (newValue == 'Today') {
                  reportsSalesProvider.dateTime = DateTime.now();
                  reportsSalesProvider.dropdownValue = 'Today';
                } else {
                  _selectDate(context, reportsSalesProvider);
                  reportsSalesProvider.dropdownValue = 'Custom';
                }
              },
            )),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, ReportsSalesProvider reportsSalesProvider) async {
    await showDatePicker(
            context: context,
            initialDate: reportsSalesProvider.dateTime,
            firstDate: DateTime(2015),
            lastDate: DateTime(2050))
        .then((value) => {
              if (value != null) {reportsSalesProvider.dateTime = value}
            });
  }
}
