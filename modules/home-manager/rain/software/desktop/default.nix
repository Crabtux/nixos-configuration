{ lib, pkgs, inputs, outputs, config, ... }:

{
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./wezterm.nix
    ./gtk.nix
  ];

  config = lib.mkIf config.rain.home-manager.software.desktop.enable {
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
