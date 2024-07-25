{ lib, config, ... }:

with lib; {
  config = mkIf config.mySystem.system.network.enable {
    networking.enableIPv6 = true;
    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = true;

    services.resolved = {
      enable = true;
      dnssec = "false";
    };
  };
}
