{ config, pkgs, desktopPorts ? import ./ports.nix, ... }:
{
  imports = [
    ../../hardware-configuration-desktop.nix
    ../../nvidiagpu.nix
    ../../packages/desktop.nix
  ];

  nixpkgs.overlays = [ (import ../../rtl88x2bu-overlay.nix) ];

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
  boot.kernelModules = [ "88x2bu" ];
  boot.blacklistedKernelModules = [ "rtl8xxxu" ];

  networking.firewall = {
    allowedTCPPorts = desktopPorts;
    allowedUDPPorts = desktopPorts;
  };

  home-manager.users.desktop = import ../../home-desktop.nix;
  home-manager.backupFileExtension = "backup";

  nix.settings.trusted-users = [ "desktop" ];

  services.displayManager = {
    sddm.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "desktop";
    sddm.wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "hyprland";

  hardware.nvidia-container-toolkit.enable = true;
}
