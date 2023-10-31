{ config, pkgs, lib, ... }:

{
  imports = [
    ./wireguard.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  services.xserver.libinput.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "C.UTF-8/UTF-8" ];
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      # Chinese and Japanese input
      fcitx5-rime
      fcitx5-mozc
    ];
  };

  # Set the default i3-sensible-terminal
  environment.sessionVariables.TERMINAL = [ "terminator" ];
  # environment.sessionVariables.http_proxy = [ "127.0.0.1:7890" ];
  # environment.sessionVariables.https_proxy = [ "127.0.0.1:7890" ];

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    # For compatability of mpd
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  };
  nixpkgs.config.pulseaudio = true;

  # Configure the fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      source-han-sans-simplified-chinese
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # 不要乱填！这玩意他妈根本不检查对不对的！
    fontconfig = {
      defaultFonts = {
        serif = [ "Source Han Serif SC" "Hack" ];
        sansSerif = [ "Source Han Sans SC" "Hack" ];
        monospace = [ "Hack" ];
      };
    };
  };

  # Set MPD
  services.mpd = {
    enable = true;
    musicDirectory = "/Music";
    user = "mpd";

    # Extra configurations
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PULSEAUDIO"
        server "127.0.0.1"
      }
    '';
  };

  # Set Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # emmm...
  services.gnome.gnome-keyring.enable = true;

  # Enable docker but it has some problems with tencent qq
  # virtualisation.docker.enable = true;

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
