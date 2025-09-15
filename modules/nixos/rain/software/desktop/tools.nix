{ config, pkgs, lib, ... }:

let
  cfg = config.rain.software.desktop.tools;
in with lib; {
  options = {
    rain.software.desktop.tools = {
      enable = mkEnableOption "desktop tools";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Wallpaper
      feh
      nitrogen

      uefitool

      # video
      mpd
      xclip
    ];

    programs.adb.enable = true;
  };
}
