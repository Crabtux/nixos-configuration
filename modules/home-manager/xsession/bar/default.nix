{ pkgs, vars, ... }:

{
  imports = [
    ( import ./polybar.nix { inherit pkgs vars; } )
  ];
}
