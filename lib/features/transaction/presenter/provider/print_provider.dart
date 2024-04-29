import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

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

  Future connect(BluetoothDevice device) async {
    final result = await bluetoothPrint.connect(device);
    if (result) {
      _tips = "Cetak";
    }
    notifyListeners();
    return result;
  }
}
