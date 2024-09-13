import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:galaxy_planets/Model/connectivity_model.dart';

class ConnectvityProvider with ChangeNotifier {
  ConnectivityModel connectivityModel = ConnectivityModel(isInternet: false);

  void checkConnectivity() {
    Connectivity connectivity = Connectivity();

    Stream<List<ConnectivityResult>> stream =
        connectivity.onConnectivityChanged;

    stream.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        connectivityModel.isInternet = true;
      } else {
        connectivityModel.isInternet = false;
      }
      notifyListeners();
    });
  }
}
