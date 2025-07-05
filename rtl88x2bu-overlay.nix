self: super: {
  rtl88x2bu = super.rtl88x2bu.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "RinCat";
      repo = "RTL88x2BU-Linux-Driver";
      # commit with kernel >=6.15 patches
      rev = "77a82dbac7192bb49fa87458561b0f2455cdc88f";
      sha256 = "1qrhd4698808axm6mliq810s3yj8aj7nv890pdvpbir8nvn6c44h";
    };
    # ensure sources compile with kbuild
    prePatch = (old.prePatch or "") + ''
      substituteInPlace Makefile --replace "-I$(src)/include" "-I$(PWD)/include"
    '';
  });
}
