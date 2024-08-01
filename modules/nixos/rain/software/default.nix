{ config, inputs, outputs, pkgs, ... }:

{
  # 分类是按照 nixpkgs repository 来的
  imports = [
    ./cli
    ./desktop
  ];
}
