{ pkgs, lib, ... }:

{
  # Nix related settings
  nix.settings = {
    substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
}
