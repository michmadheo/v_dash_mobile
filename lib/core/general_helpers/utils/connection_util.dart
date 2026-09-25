import 'package:network_info_plus/network_info_plus.dart';

class ConnectionUtil {
  ConnectionUtil._();

  static Future<void> connectionInfo() async {
    final info = NetworkInfo();

    final wifiName = await info.getWifiName();
    final wifiBSSID = await info.getWifiBSSID();
    final wifiIP = await info.getWifiIP();
    final wifiIPv6 = await info.getWifiIPv6();
    final wifiSubmask = await info.getWifiSubmask();
    final wifiBroadcast = await info.getWifiBroadcast();
    final wifiGateway = await info.getWifiGatewayIP();

    print('========== WIFI INFO ==========');
    print('WIFI Name     : $wifiName');
    print('WIFI BSSID    : $wifiBSSID');
    print('WIFI IP       : $wifiIP');
    print('WIFI IPv6     : $wifiIPv6');
    print('WIFI Submask  : $wifiSubmask');
    print('WIFI Broadcast: $wifiBroadcast');
    print('WIFI Gateway  : $wifiGateway');
    print('===============================');
  }

  static Future<String?> getWifiGateway() async {
    final info = NetworkInfo();
    String? wifiGateway = await info.getWifiGatewayIP();

    return wifiGateway;
  }
}