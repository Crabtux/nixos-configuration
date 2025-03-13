{ config, lib, pkgs, ... }:

let
  cfg = config.rain.software.desktop.applications;
in with lib; {
  options = {
    rain.software.desktop.applications = {
      enable = mkEnableOption "desktop application";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # office
      unstable.qq
      libreoffice

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
