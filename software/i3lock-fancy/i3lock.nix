{ pkgs, ... }:

{
  nixpkgs.overlays = [ 
    (final: prev: {
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
    }) 
  ];
}
