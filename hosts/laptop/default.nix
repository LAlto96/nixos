{ ... }:
{
  imports = [
    ../../hardware-configuration-laptop.nix
    ../../amdgpu.nix
    ../../packages/laptop.nix
    ../../tlp.nix
    # ../../drivers/rtl8852cu.nix
    ../../drivers/rtw89.nix
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
    size = 16 * 1024;
    priority = 0;
  }];
  boot.kernel.sysctl."vm.swappiness" = 20;

  home-manager.users.laptop = import ../../home-laptop.nix;
  nix.settings.trusted-users = [ "laptop" ];

  nixpkgs.overlays = [
    # (import ../../overlays/rtl8852cu.nix)
    (import ../../overlays/rtw89.nix)
  ];

  services.displayManager = {
    sddm.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "laptop";
    sddm.wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.udev.extraHwdb = ''
    evdev:input:b*v*p*e*
     KEYBOARD_KEY_3a=reserved
  '';
}
