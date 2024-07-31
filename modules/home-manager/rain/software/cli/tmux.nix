{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.rain.home-manager.software.cli.enable {
    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.catppuccin
      ];
    };
  };
}
