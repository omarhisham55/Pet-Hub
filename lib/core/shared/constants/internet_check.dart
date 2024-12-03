import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final _connectivityChangedController = StreamController<bool>.broadcast();
  late final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl() {
    _connectionChecker = InternetConnectionChecker();
    _startListening();
  }

  void _startListening() {
    _connectionChecker.onStatusChange.listen((status) {
      final isConnected = status == InternetConnectionStatus.connected;
      _connectivityChangedController.add(isConnected);
    });
  }

  @override
  Future<bool> get isConnected async {
    return await _connectionChecker.hasConnection;
  }

  @override
  Stream<bool> get onConnectionChanged => _connectivityChangedController.stream;

  void dispose() {
    _connectivityChangedController.close();
  }
}
