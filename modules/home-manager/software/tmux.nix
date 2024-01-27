{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
  };
}
