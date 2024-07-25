{ lib, pkgs, config, ... }:

with lib; {
  # Configure the fonts
  config = mkIf config.mySystem.system.fonts.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        source-han-sans-simplified-chinese
        (nerdfonts.override { fonts = [ "Hack" ]; })
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
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
