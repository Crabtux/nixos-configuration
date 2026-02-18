{ lib, pkgs, config, ... }:

let
  cfg = config.rain.software.cli;
in with lib; {
  imports = [
    ./neovim
  ];

  options = {
    rain.software.cli.enable = lib.mkEnableOption "CLI tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      htop
      btop
      iftop
      psmisc
      zip
      tldr
      rsync
      patchelf

      python3

      # Network Utilities
      dnsutils
      nettools
      netcat
      nmap
      wget
      iperf3

      unstable.ranger
      unstable.gemini-cli
      unstable.codex
    ];

    programs.fish.enable = true;
  };
}
