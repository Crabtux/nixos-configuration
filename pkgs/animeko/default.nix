# 2025.8.20，Nixpkgs 里的 animeko 因为缺乏维护（其实并非这个原因）被移除了，所以自己简单打一下 AppImage 的包
# 打包参考：https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools
{ appimageTools, fetchurl }:
let
  pname = "animeko";
  version = "5.0.0-beta02";

  src = fetchurl {
    url = "https://ghfast.top/https://github.com/open-ani/ani/releases/download/v5.0.0-beta02/ani-5.0.0-beta02-linux-x86_64.appimage";
    hash = "sha256-K/nlzM6u8Ch4Sk51dw15kDR9LYYKVY0HjHyCTZOlh+Y=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraPkgs = pkgs: with pkgs; [
      # 不加这个放不了视频
      libvlc
    ];

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/animeko.desktop $out/share/applications/animeko.desktop
      install -m 444 -D ${appimageContents}/icon.png $out/share/pixmaps/animeko.png
      substituteInPlace $out/share/applications/animeko.desktop \
        --replace-fail 'Exec=Ani' 'Exec=${pname}'
      substituteInPlace $out/share/applications/animeko.desktop \
        --replace-fail "icon" "animeko"
    '';
  }
