{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "rtw89-firmware";
  version = "git-7da080f"; # optionnel, juste indicatif

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    rev = "d2f175eafa0a4ef9cc65e7073a77e60238cae614";
    hash = "sha256-2LMbwZP+esxooSowEdV+cpOjU+Zn6KWQhEVfftMW15s=";
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
