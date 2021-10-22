import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool? isonline;

  startmonitoring() async {
    await initconnectivity();
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        isonline = false;
        notifyListeners();
      } else {
        await _updateconnectivitystatus().then((bool isconnected) {
          isonline = isconnected;
          notifyListeners();
        });
      }
    });
  }

  Future initconnectivity() async {
 
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        isonline = false;
        notifyListeners();
      } else {
        isonline = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _updateconnectivitystatus() async {
    bool? isconnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isconnected = true;
      }
    } on SocketException catch (e) {
      isconnected = false;
    }
    return isconnected!;
  }
}
