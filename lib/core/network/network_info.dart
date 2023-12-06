// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _dataConnectionChecker;

  NetworkInfoImpl(this._dataConnectionChecker);

  @override
  Future<bool> get isConnected async {
    final connectivityResult =
        await (_dataConnectionChecker.checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
