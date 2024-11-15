// lib/core/network/network_info.dart

/// Abstract class for checking network connectivity.
abstract class NetworkInfo {
  /// Returns `true` if the device is connected to the internet, else `false`.
  Future<bool> get isConnected;
}
