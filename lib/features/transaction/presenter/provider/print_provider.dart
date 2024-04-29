import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';

class PrintProvider with ChangeNotifier {
  final BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String _tips = "Hubungkan";
  List<BluetoothDevice> _devices = [];

  BluetoothPrint get bluetoothPrint => _bluetoothPrint;
  bool get connected => _connected;
  BluetoothDevice? get device => _device;
  List<BluetoothDevice> get devices => _devices;
  String get tips => _tips;

  set setDevice(BluetoothDevice? device) {
    _device = device;
    notifyListeners();
  }

  set setDevices(List<BluetoothDevice> devices) {
    _devices = devices;
    notifyListeners();
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          _connected = true;
          break;
        case BluetoothPrint.DISCONNECTED:
          _connected = false;
          break;
        default:
          break;
      }
    });

    if (isConnected) {
      _connected = true;
    }
  }

  Future connect() async {
    if (_device != null) {
      final result = await bluetoothPrint.connect(_device!);
      if (result) {
        _tips = "Cetak";
      }
      notifyListeners();
      return result;
    } else {
      throw "error device not selected";
    }
  }

  Future<void> print(TransactionAddResponse data) async {
    if (_connected) {
      SettingStruckService.getData().then((struck) {
        Map<String, dynamic> config = {};
        List<LineText> list = [];
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck["company"] != null
                ? "${struck["company"]}"
                : "Gading Bakery",
            weight: 2,
            width: 2,
            height: 2,
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck["alamat"] != null
                ? "Address: ${struck["alamat"]}"
                : "Address: Gading Bakery",
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck["notelp"] != null
                ? "No Hp: ${struck["notelp"]}"
                : "No Hp: ",
            weight: 0,
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));

        list.add(LineText(linefeed: 1));

        var pembayaran = 0;

        for (var i = 0; i < data.details.length; i++) {
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: data.details[i].productsName,
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1,
            ),
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content:
                  "${data.details[i].sellingPrice} x ${data.details[i].quantity}",
              align: LineText.ALIGN_LEFT,
              linefeed: 0,
              x: 0,
            ),
          );
          final total = formatRupiah(
              data.details[i].sellingPrice * data.details[i].quantity);
          pembayaran += data.details[i].sellingPrice * data.details[i].quantity;
          debugPrint(total.length.toString());
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: total,
              align: LineText.ALIGN_RIGHT,
              linefeed: 0,
              x: 200 - total.length,
            ),
          );
          list.add(LineText(linefeed: 1));
        }
        list.add(LineText(linefeed: 1));
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "Total",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(pembayaran),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: formatRupiah(pembayaran).length,
          ),
        );
        // list.add(LineText(linefeed: 1));
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "CASH",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(data.nominal),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 200 - formatRupiah(data.nominal).length,
          ),
        );

        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "Kembalian",
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 0,
          ),
        );
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: formatRupiah(data.change),
            align: LineText.ALIGN_LEFT,
            linefeed: 0,
            x: 200 - formatRupiah(data.change).length,
          ),
        );

        list.add(LineText(linefeed: 1));
        list.add(LineText(linefeed: 1));

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: struck["footer"] ?? "Terima Kasih Sudah berbelanja",
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ),
        );
        list.add(LineText(linefeed: 1));
        list.add(LineText(linefeed: 1));

        debugPrint(list.toString());

        _bluetoothPrint.printReceipt(config, list);
      });
    } else {
      throw "unconnected";
    }
  }
}
