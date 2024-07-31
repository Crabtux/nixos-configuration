{ config, inputs, outputs, pkgs, ... }:

{
  # 分类是按照 nixpkgs repository 来的
  imports = [
    ./cli
    ./desktop
  ];

  programs.adb.enable = true;
  programs.fish.enable = true;

  # Used by VS Code
  services.gnome.gnome-keyring.enable = true;
}
