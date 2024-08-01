{ config, lib, outputs, pkgs, ... }:

{
  options = {
    rain.software.desktop.applications = {
      enable = lib.mkEnableOption "desktop application";
    };
  };

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

    # Used by VS Code
    services.gnome.gnome-keyring.enable = true;
  };
}
