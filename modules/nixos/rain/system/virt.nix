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

    environment.systemPackages =
      lists.optionals cfg.docker.enable [
        pkgs.docker-compose
      ] ++
      lists.optionals cfg.wine.enable [
        pkgs.wine
      ];
  };
}
