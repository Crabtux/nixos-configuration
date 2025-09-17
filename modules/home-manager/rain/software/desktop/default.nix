{ lib, pkgs, config, outputs, ... }:

let
  cfg = config.rain.home.software.desktop;
  animeko = outputs.packages.animeko;
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
      peek
      zotero
      teamspeak_client
      slack
      obsidian

      # A GUI tool for Flatpak
      discover

      # Unstable packages
      unstable.thunderbird
      unstable.imhex
      unstable.code-cursor
      unstable.wemeet
      unstable.wechat-uos

      # Packages used by myself
      animeko
    ];
  };
}
