# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  polybar-config = pkgs.callPackage ./polybar-config { };

  sddm-rose-pine = pkgs.lib.warn 
    "⚠️sddm-rose-pine is deprecated with no Qt6 support." 
    (pkgs.callPackage ./sddm-rose-pine { });

  animeko = pkgs.callPackage ./animeko { };
}
