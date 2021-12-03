import 'package:connectivity/connectivity.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {
  final bool connected;
  MockConnectivity(this.connected);
  @override
  Future<ConnectivityResult> checkConnectivity() {
    if (connected) {
      return Future.value(ConnectivityResult.wifi);
    } else {
      return Future.value(ConnectivityResult.none);
    }
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      throw UnimplementedError();
}
