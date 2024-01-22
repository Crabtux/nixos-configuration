{ ... }:

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
        name = "theme-toaster";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-toaster";
          rev = "master";
          sha256 = "sha256-phghheRBsPXmoVZTXr6RoR8zZl3gOFH9jmMioRYdBjE=";
        };
      }
    ];
  };
}
