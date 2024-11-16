import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_info.dart';

/// Concrete implementation of [NetworkInfo] using [Connectivity] package.
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // Get the connectivity result as a list of available connection types.
    final List<ConnectivityResult> connectivityResults = await connectivity.checkConnectivity();

    // Define valid connectivity options.
    const validConnections = [
      ConnectivityResult.wifi,
      ConnectivityResult.mobile,
    ];

    // Check if the list of available connections contains a valid connection.
    return connectivityResults.any((result) => validConnections.contains(result));
  }
}
