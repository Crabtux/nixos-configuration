{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch -v";
      nixos-edit = "cd /etc/nixos; sudo vim /etc/nixos/configuration.nix; cd -;";
    };

    plugins = [
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "Catppuccin";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "main";
          sha256 = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
        };
      }
    ];
  };
}
