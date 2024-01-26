{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      background_opacity = "0.8";
    };
  };
}
