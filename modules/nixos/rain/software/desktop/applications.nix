{ config, lib, outputs, pkgs, ... }:

{
  config = lib.mkIf config.rain.software.desktop.applications.enable {
    environment.systemPackages = with pkgs; [
      # office
      qq
      libreoffice
      outputs.packages.wemeetapp

      # video
      obs-studio

      # graphics
      gimp
    ];

    # Enable flatpak for all users
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
