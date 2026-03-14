# drivers/rtw89.nix
{ config, pkgs, lib, ... }:

let
  kp = config.boot.kernelPackages;
  rtw89 = kp.callPackage ../packages/rtw89.nix {
    inherit (kp) kernel;
  };
  rtw89Firmware = pkgs.callPackage ../packages/rtw89-firmware.nix {};
in
{
  # Build the out-of-tree module against the kernel actually selected by this host.
  boot.extraModulePackages = [ rtw89 ];

  # Let udev/modprobe autoload the right module names from modaliases instead of
  # hardcoding a possibly incorrect alias such as `rtw89usb`.
  hardware.firmware = [ rtw89Firmware ];

  environment.etc = {
    "modprobe.d/rtw89.conf".source = "${rtw89}/etc/modprobe.d/rtw89.conf";

    # Recommended by morrownr/rtw89 (Q6) to prevent long boot times when the
    # USB dongle is already inserted at boot.
    "modprobe.d/usb_storage.conf".text = ''
      # This tells usb_storage not to touch Realtek USB Wi-Fi dongles.
      # Otherwise, computers may take a very long time to boot or
      # usb_modeswitch may fail to switch them to Wi-Fi mode.
      options usb_storage quirks=0bda:1a2b:i,0bda:a192:i
    '';
  };

  assertions = [
    {
      assertion = kp != null;
      message = "drivers/rtw89.nix requires config.boot.kernelPackages to be defined.";
    }
  ];
}
