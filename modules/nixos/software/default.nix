{ lib, outputs, pkgs, ... }:

{
  imports = [
    ./neovim/neovim.nix
    ./tailscale.nix
    ./nix.nix
  ];

  environment.systemPackages = with pkgs; [
    picom
    kitty
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
  ] ++ [
    outputs.packages.wemeetapp
    pkgs.unstable.cutter
  ];

  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
}
