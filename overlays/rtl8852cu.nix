self: super:
let
  buildFor = kernelPackages:
    kernelPackages.callPackage ../packages/rtl8852cu.nix {
      inherit (kernelPackages) kernel;
    };
in {
  rtl8852cu = buildFor self.linuxPackages;

  linuxPackages = super.linuxPackages.extend (ks: _:
    { rtl8852cu = buildFor ks; }
  );

  linuxPackages_zen = super.linuxPackages_zen.extend (ks: _:
    { rtl8852cu = buildFor ks; }
  );
}
