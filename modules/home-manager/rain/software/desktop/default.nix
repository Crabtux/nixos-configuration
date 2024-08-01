{ lib, pkgs, config, ... }:

let
  cfg = config.rain.home.software.desktop;
in {
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./wezterm.nix
    ./gtk.nix
  ];

  options = {
    rain.home.software.desktop = {
      enable = lib.mkEnableOption "home-manager desktop software";
    };
  };

  config = lib.mkIf cfg.enable {
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
