{ stdenv, fetchzip, pkgconfig, ffmpeg, gtk3-x11, libjpeg, gtk3, libappindicator-gtk3 }:

stdenv.mkDerivation rec {
  pname = "droidcam";
  version = "0";

  src = fetchzip {
    url = "https://github.com/dev47apps/droidcam";
    sha256 = "05kd5ihwb3fldmalv67jgpw4x0z0q39lfis69r7yh03qiqlviymk";
  };

  sourceRoot = "source/linux";

  buildInputs = [ pkgconfig ];
  nativeBuildInputs = [ ffmpeg gtk3-x11 gtk3 libappindicator-gtk3 libjpeg ];

  postPatch = ''
    sed -i -e 's:/opt/libjpeg-turbo/include:${libjpeg.out}/include:' Makefile
    sed -i -e 's:/opt/libjpeg-turbo/lib`getconf LONG_BIT`/libturbojpeg.a:${libjpeg.out}/lib/libturbojpeg.so:' Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp droidcam droidcam-cli $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "DroidCam Linux client";
    homepage = https://github.com/aramg/droidcam;
  };
}
