final: prev:
let
  # Temporary workaround for ImageMagick crashes in nixos-icons/stylix-kde-theme builds.
  goodNixpkgsRev = "fe416aaedd397cacb33a610b33d60ff2b431b127";
  goodNixpkgsNarHash = "sha256-b/GV2ysM8mKHhinse2wz+uP37epUrSE+sAKXy/xvBY4=";
  system = prev.stdenv.hostPlatform.system;
  goodNixpkgs = (builtins.fetchTree {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    rev = goodNixpkgsRev;
    narHash = goodNixpkgsNarHash;
  }).outPath;
  pinnedPkgs = import goodNixpkgs {
    inherit system;
  };
in {
  nixos-icons = pinnedPkgs.nixos-icons;
  imagemagick = pinnedPkgs.imagemagick;
}
