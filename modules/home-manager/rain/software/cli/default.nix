{ lib, pkgs, config, ... }:

let
  cfg = config.rain.home.software.cli;
in with lib; {
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
      enable = mkEnableOption "home-manager CLI software";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neofetch
      nitrogen
      (rizin.withPlugins (ps: with ps; [
        rz-ghidra
        sigdb
      ]))
      appimage-run
      cudatoolkit
      devbox
      ncdu
      unar
    ];
  };
}
