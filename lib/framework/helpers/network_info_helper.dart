import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:project_docere/domain/helpers/netork_info_helper.dart';

class NetworkInfoHelper extends INetworkInfoHelper {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoHelper({this.dataConnectionChecker});

  @override
  Future<bool> isConnected() {
    if (dataConnectionChecker != null) {
      return dataConnectionChecker.hasConnection;
    } else {
      final completer = Completer<bool>();
      completer.complete(true);
      return completer.future;
    }
  }
}
