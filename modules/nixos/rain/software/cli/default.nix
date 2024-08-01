{ lib, pkgs, config, ... }:

let
  cfg = config.rain.software.cli;
in {
  imports = [
    ./neovim
  ];

  options = {
    rain.software.cli.enable = lib.mkEnableOption "CLI tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      htop
      iftop
      psmisc
      ranger
      zip
      tldr
      rsync
      patchelf
      docker-compose

      # Network Utilities
      dnsutils
      nettools
      netcat
      nmap
      wget
      iperf3
    ];

    programs.fish.enable = true;
  };
}
