# 2023/??/??: Init
# 2024/10/30: Partially adapted from: https://github.com/NixOS/nixpkgs/pull/336638
# Currently only runs in X11
{ 
  lib, stdenv, fetchurl, dpkg, makeWrapper
, wayland, nss, nspr, zlib, xorg, freetype, libgpgerror, fontconfig, expat
, pciutils, alsaLib, harfbuzz, glib, pulseaudio, lz4, libtiff, libglvnd,
  xkeyboard_config
}:

let
  version = "3.12.0.400";
  architecture = "x86_64";
  md5 = "e078bf97365540d9f0ff063f93372a9c";

  rpath = lib.makeLibraryPath [
    expat libglvnd wayland nss nspr zlib freetype libgpgerror
    fontconfig pciutils alsaLib harfbuzz glib pulseaudio lz4 libtiff
    xorg.libSM xorg.libICE xorg.libxcb xorg.libXtst
  ] + ":${stdenv.cc.cc.lib}/lib64";

in stdenv.mkDerivation {
  name = "TencentMeeting";
  pname = "TencentMeeting";

  src = fetchurl {
    url = "https://updatecdn.meeting.qq.com/cos/${md5}/TencentMeeting_0300000000_${version}_${architecture}_default.publish.deb";
    sha256 = "sha256-NN09Sm8IepV0tkosqC3pSor4/db4iF11XcGAuN/iOpM=";
  };

  buildInputs = [
    dpkg
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    prefix=$out

    mkdir -p $out
    cp -r opt/wemeet/* $out
    cp -r usr/share $out/share

    substituteInPlace $out/share/applications/wemeetapp.desktop \
      --replace-fail /opt/wemeet $prefix

    substituteInPlace $out/share/applications/wemeetapp.desktop \
      --replace-fail wemeetapp.sh bin/wemeetapp

    runHook postInstall
  '';

  postFixup = ''
    for file in $(find $out/lib -type f \( -perm /0111 -o -name \*.so\* \) ); do
      echo "$file"
      patchelf --set-rpath $out/lib/:${rpath} $file
    done

    for file in $(find $out/bin/modules -type f \( -perm /0111 -o -name \*.so\* \) ); do
      echo "$file"
      patchelf --set-rpath $out/lib/:${rpath} $file
    done

    for file in $(find $out/plugins -type f \( -perm /0111 -o -name \*.so\* \) ); do
      echo "$file"
      patchelf --set-rpath $out/lib/:${rpath} $file
    done

    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/wemeetapp
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/QtWebEngineProcess

    patchelf --set-rpath $out/lib/:${rpath} $out/bin/wemeetapp
    patchelf --set-rpath $out/lib/:${rpath} $out/bin/QtWebEngineProcess

    # Currently I have to time figure out what `xkeyboard_config` is lol
    wrapProgram $prefix/bin/wemeetapp \
      --set XKB_CONFIG_ROOT "${xkeyboard_config}/share/X11/xkb"
  '';
}
