{ lib, pkgs, inputs, outputs, config, ... }:

{
  imports = [
    ./neovim

    ./nix.nix
    ./tailscale.nix
  ];

  options = {
    rain.software.cli.enable = lib.mkEnableOption "CLI tools";
  };
}
