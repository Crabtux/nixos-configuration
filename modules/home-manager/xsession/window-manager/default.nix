{ config, lib, vars, ... }:

{
  imports = [
    ( import ./i3wm.nix { inherit config lib vars; } )
  ];
}
