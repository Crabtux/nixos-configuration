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
      thunderbird
      remmina
      wireshark
      anki
      ghidra
      peek
      imhex
      zotero
      burpsuite
      teamspeak_client
      slack

      # A GUI tool for Flatpak
      discover
    ];
  };
}
