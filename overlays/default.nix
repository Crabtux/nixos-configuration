# This file defines overlays
{ inputs, pkgs, ... }: 

{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    polybar = prev.polybar.override { 
      mpdSupport = true; 
      i3Support = true;
    };

    i3lock-fancy = prev.i3lock-fancy.overrideAttrs (finalAttrs: previousAttrs: {
      postPatch = ''
        sed -i i3lock-fancy \
          -e "s|mktemp|${pkgs.coreutils}/bin/mktemp|" \
          -e "s|'rm -f |'${pkgs.coreutils}/bin/rm -f |" \
          -e "s|scrot -z |${pkgs.scrot}/bin/scrot -z |" \
          -e "s|convert |${pkgs.imagemagick.out}/bin/convert |" \
          -e "s|awk -F|${pkgs.gawk}/bin/awk -F|" \
          -e "s| awk | ${pkgs.gawk}/bin/awk |" \
          -e "s|i3lock -i |${pkgs.i3lock-color}/bin/i3lock-color --ring-color=#f699cdcc --keyhl-color=#ffffffcc --separator-color=#ddddddcc -i |" \
          -e 's|icon="/usr/share/i3lock-fancy/icons/lockdark.png"|icon="'$out'/share/i3lock-fancy/icons/lockdark.png"|' \
          -e 's|icon="/usr/share/i3lock-fancy/icons/lock.png"|icon="'$out'/share/i3lock-fancy/icons/lock.png"|' \
          -e "s|getopt |${pkgs.getopt}/bin/getopt |" \
          -e "s|fc-match |${pkgs.fontconfig.bin}/bin/fc-match |" \
          -e "s|shot=(import -window root)|shot=(${pkgs.scrot}/bin/scrot -z -o)|" \
          -e "s|^font.*|font='DejaVu-Sans' |"
        rm Makefile
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
