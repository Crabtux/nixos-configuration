{ ... }:

{
  networking.enableIPv6 = true;
  networking.useDHCP = true;
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
