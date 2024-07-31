{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.rain.software.desktop.tools.enable {
    environment.systemPackages = with pkgs; [
      # analysis
      (cutter.withPlugins (ps: with ps; [
        rz-ghidra
        sigdb
      ]))

      # Wallpaper Manager
      nitrogen
      uefitool
    ];
  };
}
