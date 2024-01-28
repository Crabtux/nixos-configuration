{ 
  lib, stdenv, fetchurl, dpkg
, wayland, nss, nspr, zlib, xorg, freetype, libgpgerror, fontconfig, expat
, pciutils, alsaLib, harfbuzz, glib, pulseaudio, lz4, libtiff, libglvnd
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

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/opt/wemeet/* $out
    rm -rf $out/opt $out/usr
    
    # Otherwise it looks "suspicious"
    chmod -R g-w $out
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
  '';
}
