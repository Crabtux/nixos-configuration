{ pkgs, ... }:

{
  # A simple derivation as a wrapper
  polybar-config = pkgs.stdenv.mkDerivation {
    name = "polybar-config";
    phases = [ "unpackPhase" "installPhase" ];
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cp -r $src/docky/ $out
    '';
  };
}
