{ config, inputs, outputs, pkgs, ... }:

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
    psmisc
    mpd
    libreoffice
    qq
    ranger
    rofi
    obs-studio
    xclip
    zip
    tldr
    rsync
    julia-bin
    uefitool
    gimp
    patchelf
    docker-compose

    # Network Utilities
    dnsutils
    nettools
    netcat
    nmap
    wget
    iperf3
    wpa_supplicant_gui

    # Wallpaper Manager
    nitrogen

    # ScreenSaver
    i3lock-fancy
  ] ++ [
    outputs.packages.wemeetapp
    (cutter.withPlugins (ps: with ps; [
      rz-ghidra
      sigdb
    ]))
  ];

  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.nix-ld.enable = true;

  # Used by VS Code
  services.gnome.gnome-keyring.enable = true;
}
