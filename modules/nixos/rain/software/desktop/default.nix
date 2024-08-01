{ lib, ... }:

with lib; {
  imports = [
    ./applications.nix
    ./games.nix
    ./tools.nix
  ];
}
