{ ... }:
{
  imports = [
    ../../hardware-configuration-laptop.nix
    ../../amdgpu.nix
    ../../packages/laptop.nix
    ../../tlp.nix
    ../../drivers/rtl8852cu.nix
  ];

  networking.firewall = {
    allowedTCPPorts = [ 80 91 443 444 8501 9100 ];
    allowedUDPPorts = [ 80 91 443 444 8501 9100 ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  home-manager.users.laptop = import ../../home-laptop.nix;
  nix.settings.trusted-users = [ "laptop" ];

  nixpkgs.overlays = [ (import ../../overlays/rtl8852cu.nix) ];

  services.displayManager = {
    sddm.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "laptop";
    sddm.wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "hyprland";
}
