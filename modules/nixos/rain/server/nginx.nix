{ pkgs, ... }:

{
  services.nginx.enable = true;

  services.nginx.virtualHosts."ctf" = {
    addSSL = false;
    enableACME = false;
    root = "/var/www/ctf";
    extraConfig = ''
      charset UTF-8;
      autoindex on;
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [
      80 443
      # Used by beebeep
      6475 6476
    ];
  };
}
