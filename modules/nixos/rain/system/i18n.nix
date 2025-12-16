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
        # See also: https://zhuanlan.zhihu.com/p/1963358188226183647
        (fcitx5-rime.override {
          rimeDataPkgs = [
            pkgs.rime-ice
          ];
        })
        fcitx5-rose-pine
        fcitx5-mozc
      ];
    };
  };
}
