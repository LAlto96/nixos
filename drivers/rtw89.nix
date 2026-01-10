# drivers/rtw89.nix
{ config, pkgs, lib, ... }:

let
  kp = config.boot.kernelPackages;

  # IMPORTANT: `kp ? rtw89` is not enough because kp.rtw89 can exist but be null.
  hasRtw89 = kp != null && (kp ? rtw89) && (kp.rtw89 != null);
in
{
  # If the module is built-in / not available, this is harmless; if it causes issues,
  # we can also guard it the same way.
  boot.kernelModules = [ "rtw89usb" ];

  # Only add the out-of-tree module package if it actually exists and is not null.
  boot.extraModulePackages = lib.optionals hasRtw89 [
    kp.rtw89
  ];

  # Firmware (fine to keep)
  hardware.firmware = [ pkgs.rtw89-firmware ];

  # environment.etc: only define the entry when rtw89 is a real derivation/path
  environment.etc = lib.optionalAttrs hasRtw89 {
    "modprobe.d/rtw89.conf".source = "${kp.rtw89}/etc/modprobe.d/rtw89.conf";
  };
}
