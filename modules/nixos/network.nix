{ lib, ... }:

{
  networking.enableIPv6 = true;
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
