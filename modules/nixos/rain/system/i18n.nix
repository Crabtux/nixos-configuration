{ lib, config, pkgs, ... }:

let
  cfg = config.rain.system.i18n;
in with lib; {
  options = {
    rain.system.i18n = {
      enable = mkEnableOption "system bluetooth";
    };
  };

  config = mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Asia/Shanghai";
  
    # Select internationalisation properties.
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
  };
}
