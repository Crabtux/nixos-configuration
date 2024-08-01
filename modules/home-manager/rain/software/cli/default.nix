{ lib, pkgs, config, ... }:

let
  cfg = config.rain.home.software.cli;
in {
  imports = [
    # ./neovim

    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gnupg.nix
    ./tmux.nix
    ./home-manager.nix
  ];

  options = {
    rain.home.software.cli = {
      enable = lib.mkEnableOption "home-manager CLI software";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      neofetch
      clash-meta
      nitrogen
      (rizin.withPlugins (ps: with ps; [
        rz-ghidra
        sigdb
      ]))
      appimage-run
      cudatoolkit
      ncdu
      unar
    ];
  };
}
