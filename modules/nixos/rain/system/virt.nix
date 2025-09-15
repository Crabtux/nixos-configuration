{ pkgs, lib, config, ... }:

let
  cfg = config.rain.system.virt;
in with lib; {
  options = {
    rain.system.virt = {
      enable = mkEnableOption "Virtulization";
      virt-manager.enable = mkEnableOption "virt-manager";
      docker.enable = mkEnableOption "Docker";
      wine.enable = mkEnableOption "Wine";
    };
  };

  config = mkIf cfg.enable {
    # Basic
    users.groups.libvirtd.members = ["crabtux"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    programs.virt-manager.enable = mkIf cfg.virt-manager.enable true;

    virtualisation.docker.enable = mkIf cfg.docker.enable true;

    environment.systemPackages = with pkgs;
      mkIf cfg.wine.enable [
        # https://nixos.wiki/wiki/Wine
        # On x86_64-linux, the wine package supports by default both 32-bit and 64-bit applications.
        wine
      ];
  };
}
