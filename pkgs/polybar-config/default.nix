{ stdenv, ... }:

stdenv.mkDerivation {
  name = "polybar-config";
  phases = [ "unpackPhase" "installPhase" ];
  src = ./config;
  installPhase = ''
    mkdir -p $out
    cp -r $src $out/docky
  '';
}
