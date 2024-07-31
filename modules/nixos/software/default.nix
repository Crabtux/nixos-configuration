{ config, inputs, outputs, pkgs, ... }:

{
  # 分类是按照 nixpkgs repository 来的
  imports = [
    ./cli
    ./desktop
  ];

  environment.systemPackages = with pkgs; [
    picom
    neovim
    feh
    git
    htop
    iftop
    psmisc
    mpd
    ranger
    xclip
    zip
    tldr
    rsync
    julia-bin
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

  programs.adb.enable = true;
  programs.fish.enable = true;

  # Used by VS Code
  services.gnome.gnome-keyring.enable = true;
}
