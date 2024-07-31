{ config, pkgs, lib, ... }:

{
  # Nix related settings
  config = lib.mkIf config.rain.software.cli.enable {
    nix.settings = {
      substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org" ];
      experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs.config.allowUnfree = true;
  };
}
