# drivers/rtw89.nix
{ config, pkgs, ... }:
{
  # Module “bus” (USB)
  boot.kernelModules = [ "rtw89usb" ];

  # Package kernel-module buildé via ton overlay
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtw89 ];

  # Firmware (recommandé/nécessaire)
  hardware.firmware = [ pkgs.rtw89-firmware ];

  # Optionnel mais recommandé : conf modprobe fournie par le repo
  environment.etc."modprobe.d/rtw89.conf".source =
    "${config.boot.kernelPackages.rtw89}/etc/modprobe.d/rtw89.conf";
}
