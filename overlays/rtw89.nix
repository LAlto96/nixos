# overlays/rtw89.nix
self: super:
let
  buildFor = kernelPackages:
    kernelPackages.callPackage ../packages/rtw89.nix {
      inherit (kernelPackages) kernel;
    };
in {
  # Expose un package "rtw89" buildé pour le kernel "par défaut"
  rtw89 = buildFor self.linuxPackages;

  linuxPackages = super.linuxPackages.extend (ks: _:
    { rtw89 = buildFor ks; }
  );

  linuxPackages_zen = super.linuxPackages_zen.extend (ks: _:
    { rtw89 = buildFor ks; }
  );

  linuxPackages_latest = super.linuxPackages_latest.extend (ks: _:
    { rtw89 = buildFor ks; }
  );

  # Firmware (non dépendant du kernel)
  rtw89-firmware = super.callPackage ../packages/rtw89-firmware.nix {};
}
