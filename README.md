# NixOS-configuration

里面貌似有：

- 一个给 PC 用的 NixOS + Home Manager 配置
  - Home Manager 作为 NixOS 的模块使用
- 一个给服务器用的 Standalone Home Manager 配置。

有点乱，但我暂时改不动了（

## 一些信息

- Shell: Fish
- Terminal Emulator: Wezterm
- Fonts:
  - zh: Source Han Sans (zh-CN)
  - en: Hack
- Desktop Manager: Xfce
- Window Manager: i3wm
- Display Manager: Lightdm
- Screensaver: i3lock-fancy with xautolock
- Application Launcher: Rofi
- Status Bar: Polybar
- Compositor: Picom

Polybar 和 Rofi 的主题，修改自 [adi1090x/polybar-themes](https://github.com/adi1090x/polybar-themes)。

## TODO

- 给这个 [鼠标指针主题](https://www.xfce-look.org/p/2077667) 打包
- 在更多机器上使用 Nix 和 NixOS
- Secret Management（比如用 sops-nix）
