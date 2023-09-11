{ pkgs, lib, ... }:

{
  # Nix related settings
  nix.settings = {
    substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  systemd.services.nix-daemon.environment = {
    http_proxy = "127.0.0.1:7890";
    https_proxy = "127.0.0.1:7890";
  };

  nixpkgs.config.allowUnfree = true;
}
