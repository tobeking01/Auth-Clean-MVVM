import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_info.dart';

/// Concrete implementation of [NetworkInfo] using [Connectivity] package.
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // Fetch the connectivity result
    final ConnectivityResult connectivityResult =
        (await connectivity.checkConnectivity()) as ConnectivityResult;

    // Define valid connectivity types
    final List<ConnectivityResult> validConnections = [
      ConnectivityResult.wifi,
      ConnectivityResult.mobile,
    ];

    // Return true if the result matches any valid connection
    return validConnections.contains(connectivityResult);
  }
}
