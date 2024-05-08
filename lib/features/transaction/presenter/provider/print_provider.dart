import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:garing_bakery_apk/core/helpers/format_rupiah.dart';
import 'package:garing_bakery_apk/features/printer/data/service/struck_service.dart';
import 'dart:async';
import 'package:garing_bakery_apk/features/transaction/data/model/reponse_add.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrintProvider with ChangeNotifier {
  final BlueThermalPrinter _bluetoothPrint = BlueThermalPrinter.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String _tips = "Hubungkan";
  List<BluetoothDevice> _devices = [];

  BlueThermalPrinter get bluetoothPrint => _bluetoothPrint;
  bool get connected => _connected;
  BluetoothDevice? get device => _device;
  List<BluetoothDevice> get devices => _devices;
  String get tips => _tips;

  set setDevice(BluetoothDevice? device) {
    _device = device;
    notifyListeners();
  }

  set setTips(String tips) {
    _tips = tips;
    notifyListeners();
  }

  set setDevices(List<BluetoothDevice> devices) {
    _devices = devices;
    notifyListeners();
  }

  Future<List<BluetoothDevice>> getDevices() async {
    _devices = await _bluetoothPrint.getBondedDevices();
    notifyListeners();
    return _devices;
  }

  Future<bool> connect({BluetoothDevice? device}) async {
    if (device != null) {
      _device = device;
    }
    try {
      if (_device != null) {
        debugPrint(_connected.toString());
        bool? conn = await _bluetoothPrint.isConnected;
        if (conn == null || conn == false) {
          _tips = "Sedang Menghubungkan";
          await _bluetoothPrint.connect(_device!);
          _connected = (await _bluetoothPrint.isConnected)!;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("print_name", _device!.name!);
          prefs.setString("print_address", _device!.address!);
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      _bluetoothPrint.disconnect();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("ok");
      return false;
    }
  }

  Future<bool> print(TransactionAddResponse data) async {
    debugPrint("Hallo");
    debugPrint((await _bluetoothPrint.isConnected)!.toString());
    if ((await _bluetoothPrint.isConnected)!) {
      SettingStruckService.getData().then((struck) {
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printCustom(struck["company"], 3, 1);
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printCustom(struck["alamat"], 1, 1);
        _bluetoothPrint.printCustom(struck["notelp"], 1, 1);
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printCustom("------------------------------", 0, 1);
        DateFormat formatter =
            DateFormat('EEEE, dd MMMM yyyy, HH:mm:ss', 'id_ID');
        _bluetoothPrint.printCustom(formatter.format(data.createdAt), 0, 1);
        _bluetoothPrint.printCustom("------------------------------", 0, 1);
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printCustom("------------------------------", 0, 0);
        int pembayaran = 0;
        for (var i = 0; i < data.details.length; i++) {
          _bluetoothPrint.printCustom(data.details[i].productsName, 0, 0);
          // _bluetoothPrint.printCustom(
          //     "${data.details[i].sellingPrice} x ${data.details[i].quantity}",
          //     1,
          //     0);
          // _bluetoothPrint.printCustom(c, 0, 2);
          pembayaran += data.details[i].sellingPrice * data.details[i].quantity;
          _bluetoothPrint.printLeftRight(
              "${data.details[i].sellingPrice} x ${data.details[i].quantity}",
              formatRupiah(
                  data.details[i].sellingPrice * data.details[i].quantity),
              0);
        }
        _bluetoothPrint.printCustom("------------------------------", 0, 0);
        _bluetoothPrint.printLeftRight("Total", formatRupiah(pembayaran), 0);
        _bluetoothPrint.printLeftRight("CASH", formatRupiah(data.nominal), 0);
        _bluetoothPrint.printLeftRight(
            "Kembalian", formatRupiah(data.change), 0);

        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printCustom(struck["footer"], 1, 1);
        _bluetoothPrint.printNewLine();
        _bluetoothPrint.printNewLine();

        debugPrint(struck.toString());
      });
      return true;
    } else {
      return false;
    }
  }
}
