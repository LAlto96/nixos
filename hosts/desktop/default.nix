{ desktopPorts ? import ./ports.nix, ... }:
{
  imports = [
    ../../hardware-configuration-desktop.nix
    ../../nvidiagpu.nix
    ../../packages/desktop.nix
    ../../drivers/rtl8852cu.nix
  ];

  networking.firewall = {
    allowedTCPPorts = desktopPorts;
    allowedUDPPorts = desktopPorts;
  };

  services.openssh = {
    enable = true;
    ports = [ 2268 ];
  };

  home-manager.users.desktop = import ../../home-desktop.nix;
  home-manager.backupFileExtension = "backup";

  nixpkgs.overlays = [ (import ../../overlays/rtl8852cu.nix) ];

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
