# NixOS-configuration

The configuration is currently not completed. I'm just too lazy to write a lot of code.

~~Making the repository public is just a way of reminding myself to update the configuration more frequently XD~~

## Some information

- Shell: Fish
- Fonts: Hack (with nerd font) & Source Han Sans
- Display Manager: Lightdm
- Window Manager: i3wm
- Desktop Manager: Xfce
- Screensaver: i3lock-fancy with xautolock
- Application Launcher: Rofi
- Status Bar: Polybar
- Compositor: Picom
- Program Editor: Neovim
- Browser: Firefox

The Polybar and Rofi themes are modified from [adi1090x/polybar-themes](https://github.com/adi1090x/polybar-themes).

Development environments are defined in `shell.nix` in the development directory (currently not included in this repository, maybe one day I will upload them).

## TODO

- Pack a cursor theme from <https://www.xfce-look.org/p/2077667>
- Add secret management system (maybe sops-nix?)
- Continue to configure home-manager
- Purify the configuration so that it can be installed on other computers
