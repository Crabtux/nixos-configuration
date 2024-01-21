{ config, lib, pkgs, ... }:

let 
  vars = {
    # A simple derivation as a wrapper for polybar config
    polybar-config = pkgs.stdenv.mkDerivation {
      name = "polybar-config";
      phases = [ "unpackPhase" "installPhase" ];
      src = ./bar;
      installPhase = ''
        mkdir -p $out
        cp -r $src/docky/ $out
      '';
    };
  };
in {
  imports = [
    ( import ./bar { inherit pkgs vars; } )
    ( import ./window-manager { inherit config lib vars; } )
    ./app-menu
    ./compositor
    ./screensaver
  ];
}
