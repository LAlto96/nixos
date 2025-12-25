{ lib, stdenv, fetchFromGitHub, kernel, bc, nukeReferences }:

stdenv.mkDerivation {
  pname = "rtl8852cu";
  version = "${kernel.version}-20240510";

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtl8852cu-20240510";
    rev = "c01bd409ddce75822cd9127ac1a97ba4fd31a9d8";
    hash = "sha256-yp5e2ijkqKji+dJ+XPMJJPhkjh5NYUiFEncQc4HdNEA=";
  };

  nativeBuildInputs = [ bc nukeReferences ] ++ kernel.moduleBuildDependencies;
  hardeningDisable = [ "pic" "format" ];

  # 1) Ajustements Makefile, 2) shim pour Linux >= 6.16
  prePatch = ''
    substituteInPlace Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/" \
      --replace '/etc/modprobe.d' "$out/etc/modprobe.d" \
      --replace 'sh edit-options.sh' 'true'

    # Compat noyau 6.16+: reintroduire from_timer() si absent
    # On ajoute les includes et une définition de secours.
    sed -i '1i\
#include <linux/version.h>\n#include <linux/timer.h>\n#ifndef from_timer\n# ifdef timer_container_of\n#  define from_timer(var, callback_timer, timer_fieldname) \\\n     timer_container_of(var, callback_timer, timer_fieldname)\n# else\n#  define from_timer(var, callback_timer, timer_fieldname) \\\n     container_of(callback_timer, typeof(*(var)), timer_fieldname)\n# endif\n#endif\n' \
      ./include/osdep_service_linux.h
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
    # Non-mainline, sensible aux changements d'API noyau >= 6.16.
    broken = false;
  };
}
