# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  wemeetapp = pkgs.callPackage ./wemeetapp { };
  polybar-config = pkgs.callPackage ./polybar-config { };
  sddm-rose-pine = pkgs.callPackage ./sddm-rose-pine { };
}
