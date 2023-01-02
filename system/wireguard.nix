{ config, pkgs, lib, ... }:

{
  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "192.168.115.2/24" ];

      # Use SNMP port as a workaround of UDP QoS
      listenPort = 161;

      # Path to the private key file.
      privateKeyFile = "/home/crabtux/.wireguard/private";
      
      allowedIPsAsRoutes = false;

      peers = [
        # For a client configuration, one peer entry for the server will suffice.
        {
          # Public key of the server (not a file path).
          publicKey = "ElfHCQjxV2SjH7+3IWIFyc1vT19ScKnC4AN6FHIQCGE=";

          # set allowedIPs but not to add the route by default
          allowedIPs = [ "192.168.115.0/24" ];

          # Set this to the server IP and port.
          endpoint = "13.115.220.43:2333";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
