{ pkgs, inputs, outputs, config, ... }:

{
  imports = [
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gnupg.nix
    ./tmux.nix
    ./home-manager.nix
  ];

  config = {
    home.packages = with pkgs; [
      neofetch
      clash-meta
      nitrogen
      (rizin.withPlugins (ps: with ps; [
        rz-ghidra
        sigdb
      ]))
      appimage-run
      cudatoolkit
      ncdu
      unar
    ];
  };
}
