import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:intl/intl.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownvalue = 'Today';
  DateTime currentDate = DateTime.now();
  String today =
      DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
  var filter = [
    'Today',
    'Yesterday',
    'Custom',
  ];

  @override
  void initState() {
    today = DateFormat("EEEE, d MMMM yyyy", "id_ID").format(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              value: dropdownvalue,
              items: filter.map((String items) {
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
                setState(() {
                  dropdownvalue = newValue!;
                  if (dropdownvalue == 'Yesterday') {
                    currentDate =
                        DateTime.now().subtract(const Duration(days: 1));
                  } else if (dropdownvalue == 'Today') {
                    currentDate = DateTime.now();
                  } else {
                    _selectDate(context);
                  }
                });
              },
            )),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(2015),
            lastDate: DateTime(2050))
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    currentDate = value;
                  })
                }
            });
  }
}
