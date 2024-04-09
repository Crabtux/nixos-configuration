{ config, outputs, pkgs, ... }:

{
  imports = [
    ./neovim/neovim.nix
    ./tailscale.nix
    ./nix.nix
  ];

  environment.systemPackages = with pkgs; [
    picom
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
    uefitool
    gimp
    docker-compose

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
    (cutter.withPlugins (ps: with ps; [ rz-ghidra sigdb ]))
    config.nur.repos.xddxdd.wechat-uos
  ];

  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
}
