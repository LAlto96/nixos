# packages/rtw89.nix
{ lib
, stdenv
, fetchFromGitHub
, kernel
, bc
, nukeReferences
}:

stdenv.mkDerivation rec {
  pname = "rtw89";
  # Recommandation: mets une date/rev explicite comme tu faisais.
  version = "git-2025-xx-xx"; # à ajuster

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    # Choisis un rev précis (commit SHA)
    rev = "7da080fc2fc75709364943c7ef2b39fa5abcef77";
    hash = "sha256-psl39LMyXZh4Not6qWSdanze19GX0G52QbtLM7cO8JA=";
  };

  nativeBuildInputs = [ bc nukeReferences ] ++ kernel.moduleBuildDependencies;

  hardeningDisable = [ "pic" "format" ];

  # Build Kbuild out-of-tree
  buildPhase = ''
    runHook preBuild

    # Nettoyage (optionnel)
    # Le README mentionne "make clean modules". :contentReference[oaicite:2]{index=2}
    # On fait un clean "soft" si présent, sinon on ignore.
    make clean || true

    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M="$PWD" \
      modules

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    moddir=$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtw89
    mkdir -p "$moddir"

    # Copie toutes les .ko générées (core, pci/usb, puces…)
    find . -maxdepth 2 -type f -name '*.ko' -print -exec cp -v {} "$moddir/" \;

    # Fournit aussi le fichier de conf recommandé par le repo (blacklist conflits)
    # Le README demande de copier rtw89.conf dans /etc/modprobe.d/. :contentReference[oaicite:3]{index=3}
    mkdir -p $out/etc/modprobe.d
    if [ -f rtw89.conf ]; then
      cp -v rtw89.conf $out/etc/modprobe.d/rtw89.conf
    fi

    # Nettoyage refs (comme tu faisais)
    nuke-refs "$moddir"/*.ko || true

    runHook postInstall
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Realtek rtw89 (out-of-kernel) Wi-Fi 6/6E/7 driver bundle (morrownr)";
    homepage = "https://github.com/morrownr/rtw89";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
