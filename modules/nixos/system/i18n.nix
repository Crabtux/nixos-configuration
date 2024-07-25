{ lib, config, pkgs, ... }:

with lib; {
  config = mkIf config.mySystem.system.i18n.enable {
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
