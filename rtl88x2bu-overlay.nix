self: super: {
  rtl88x2bu = super.rtl88x2bu.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "RinCat";
      repo = "RTL88x2BU-Linux-Driver";
      rev = "master"; # or a specific tag compatible with kernel >=6.15
      sha256 = "1qrhd4698808axm6mliq810s3yj8aj7nv890pdvpbir8nvn6c44h";
    };
  });
}
