{ config, pkgs, nixpkgs-unstable, lib, ... }:

let
  wemeetapp = pkgs.callPackage ./wemeetapp/default.nix {};
in {
  imports = [
    ./v2ray/v2ray.nix
    ./neovim/neovim.nix
    ./tailscale/tailscale.nix
    ./zsh/zsh.nix
    ./nix/nix.nix
    ./polybar/polybar.nix
    ./i3lock-fancy/i3lock.nix
  ];

  environment.systemPackages = with pkgs; [
    picom
    terminator
    neovim
    feh
    git
    polybar
    htop
    iftop
    tailscale
    xwinwrap
    pywal
    psmisc
    mpd
    sops
    glibcLocales
    marktext
    libreoffice
    qq
    ranger
    rofi
    bottles
    obs-studio
    wemeetapp
    xclip
    zip
    tldr
    rsync
    julia-bin
    gimp

    # Network Utilities
    dnsutils
    nettools
    netcat
    udp2raw
    nmap
    wget
    iperf3
    wpa_supplicant_gui
    rpi-imager

    # Wallpaper Manager
    nitrogen

    # ScreenSaver
    i3lock-fancy
  ];

   programs.adb.enable = true;
}
