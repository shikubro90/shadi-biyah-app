library check_vpn_connection;

import 'dart:io';

///A class that contains static method of checking VPN connection
class CheckVpnConnection {
  ///Returns true if device has VPN connection
  Future<bool> isVpnActive() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.any,
      );
      return interfaces.any((interface) => [
            "tun", "tap", // OpenVPN
            "ppp", // PPTP
            "l2tp", // L2TP
            "ipsec", // IPSec
            "vpn", "anyconnect", // Cisco AnyConnect
            "ikev2", // IKEv2
            "sstp", // SSTP
            "wireguard", // WireGuard
            "openconnect", "ocserv", // OpenConnect (AnyConnect-compatible)
            "forticlient", "fortisslvpn", // FortiClient
            "softether", // SoftEther VPN
            "strongswan", "charon", // StrongSwan
            "openfortivpn", // OpenFortiVPN
            "zerotier", // ZeroTier
          ].any((pattern) => interface.name.toLowerCase().contains(pattern)));
    } catch (e) {
      // Handle exceptions, e.g., if the network interface list cannot be retrieved
      rethrow;
    }
  }
}
