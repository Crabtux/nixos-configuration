{ ... }:

{
  # Configure the fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
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
}
