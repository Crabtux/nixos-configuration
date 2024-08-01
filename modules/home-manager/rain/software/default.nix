{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./cli
  ];
}
