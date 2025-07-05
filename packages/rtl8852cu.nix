{ lib, stdenv, fetchFromGitHub, kernel, bc, nukeReferences }:

stdenv.mkDerivation {
  pname = "rtl8852cu";
  version = "${kernel.version}-20240510";

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtl8852cu-20240510";
    rev = "474d61a3cabafc341b12de6f96e3a91ee0157288";
    hash = "sha256-6JwRlpr4T7ahhFSw8vbrstDnaSF/QOIMB0mVtPckoF0=";
  };

  nativeBuildInputs = [ bc nukeReferences ] ++ kernel.moduleBuildDependencies;
  hardeningDisable = [ "pic" "format" ];

  prePatch = ''
    substituteInPlace Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/" \
      --replace '/etc/modprobe.d' "$out/etc/modprobe.d" \
      --replace 'sh edit-options.sh' 'true'
  '';

  makeFlags = [
    "KVER=${kernel.modDirVersion}"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  preInstall = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
    mkdir -p $out/etc/modprobe.d
  '';

  postInstall = ''
    nuke-refs $out/lib/modules/*/kernel/drivers/net/wireless/*.ko
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Realtek RTL8852CU USB WiFi driver";
    homepage = "https://github.com/morrownr/rtl8852cu-20240510";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
