# 2025.8.20，Nixpkgs 里的 animeko 因为缺乏维护被移除了，所以自己简单打一下 AppImage 的包
# 打包参考：https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools
{ appimageTools, fetchurl }:
let
  pname = "animeko";
  version = "4.11.1";

  src = fetchurl {
    url = "https://ghfast.top/https://github.com/open-ani/animeko/releases/download/v4.11.1/ani-4.11.1-linux-x86_64.appimage";
    hash = "sha256-OLcETfESuS4yp8Rh0HCCXEWLjeTnXUE/DClnFU0Fcrg=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    # 不加这个放不了视频哦
    extraPkgs = pkgs: with pkgs; [
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
