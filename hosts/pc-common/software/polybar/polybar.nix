{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: { 
    polybar = pkgs.polybar.override { 
      mpdSupport = true; 
      i3Support = true;
    };
  };
}
