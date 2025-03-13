{ lib, pkgs, config, ... }:

let
  cfg = config.rain.home.software.desktop;
in with lib; {
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./wezterm.nix
    ./gtk.nix
  ];

  options = {
    rain.home.software.desktop = {
      enable = mkEnableOption "home-manager desktop software";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tdesktop
      remmina
      wireshark
      anki
      ghidra
      peek
      zotero
      burpsuite
      teamspeak_client
      slack

      # A GUI tool for Flatpak
      discover

      # Unstable packages
      unstable.thunderbird
      unstable.imhex
      unstable.code-cursor
      unstable.wemeet
    ];
  };
}
