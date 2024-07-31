{ pkgs, ... }:

let 
  rose-pine = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "main";
    sha256 = "sha256-bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch -v";
      nixos-edit = "cd /etc/nixos; sudo vim /etc/nixos/configuration.nix; cd -;";
    };
    plugins = [
      {
        name = "theme-clearance";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-clearance";
          rev = "master";
          sha256 = "sha256-r8/wT8PgJcE05UcxJR8ZRf9xBnDajmwKDOiD12TRWyk=";
        };
      }
    ];
  };

  xdg.configFile = {
    "fish/themes/Rosé Pine.theme".source = "${rose-pine}/themes/Rosé Pine.theme";
  };
}
