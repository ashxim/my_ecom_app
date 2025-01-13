import 'dart:io' show Platform;

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected async => Platform.isAndroid || Platform.isIOS
      ? await connectionChecker.hasConnection
      : true;
}
