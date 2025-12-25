{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "rtw89-firmware";
  version = "git-7da080f"; # optionnel, juste indicatif

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    rev = "7da080fc2fc75709364943c7ef2b39fa5abcef77";
    hash = "sha256-psl39LMyXZh4Not6qWSdanze19GX0G52QbtLM7cO8JA=";
  };

  # Important : sinon stdenv voit un Makefile et lance make
  dontConfigure = true;
  dontBuild = true;

  # Encore plus strict : on ne garde que unpack + install
  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    set -euo pipefail

    mkdir -p $out/lib/firmware

    if [ ! -d firmware ]; then
      echo "rtw89-firmware: firmware/ directory not found in source" >&2
      exit 1
    fi

    cp -rv firmware/* $out/lib/firmware/
  '';

  meta = with lib; {
    description = "Firmware files shipped with morrownr/rtw89";
    homepage = "https://github.com/morrownr/rtw89";
    # c’est du firmware redistribuable ; la licence exacte varie selon les blobs
    license = licenses.unfreeRedistributableFirmware or licenses.unfree;
    platforms = platforms.linux;
  };
}
