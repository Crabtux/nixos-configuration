{ lib, pkgs, inputs, outputs, config, ... }:

{
  imports = [
    ./neovim

    ./nix.nix
    ./tailscale.nix
  ];

  options = {
    mySystem.software.cli.enable = lib.mkEnableOption "CLI tools";
  };
}
