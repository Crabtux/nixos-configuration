{ lib, ... }:

with lib; {
  imports = [ 
    ./boot
    ./sound

    ./bluetooth.nix
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./virt.nix
  ];
}
