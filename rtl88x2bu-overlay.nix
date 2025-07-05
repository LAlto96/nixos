self: super: {
  linuxPackagesFor = kernel: let
    base = super.linuxPackagesFor kernel;
  in base.extend (final: prev: {
    rtl88x2bu = prev.rtl88x2bu.overrideAttrs (old: {
      src = super.fetchFromGitHub {
        owner = "RinCat";
        repo = "RTL88x2BU-Linux-Driver";
        rev = "77a82dbac7192bb49fa87458561b0f2455cdc88f"; # commit with 6.15 patches
        sha256 = "1qrhd4698808axm6mliq810s3yj8aj7nv890pdvpbir8nvn6c44h";
      };
      prePatch = (old.prePatch or "") + ''
        sed -i 's|-I\\$(src)/include|-I\\$(PWD)/include|' Makefile
      '';
    });
  });
}
