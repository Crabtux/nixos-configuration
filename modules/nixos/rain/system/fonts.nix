{ lib, pkgs, config, ... }:

let
  cfg = config.rain.system.fonts;
in with lib; {
  options = {
    rain.system.fonts = {
      enable = mkEnableOption "system fonts";
    };
  };

  # Configure the fonts
  config = mkIf config.rain.system.fonts.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        source-han-sans
        nerd-fonts.hack
        # noto-fonts
        # noto-fonts-cjk
        # noto-fonts-emoji
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
  };
}
