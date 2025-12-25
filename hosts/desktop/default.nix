{ desktopPorts ? import ./ports.nix, ... }:
{
  imports = [
    ../../hardware-configuration-desktop.nix
    ../../nvidiagpu.nix
    ../../packages/desktop.nix
    # ../../drivers/rtl8852cu.nix
    ../../drivers/rtw89.nix
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

  nixpkgs.overlays = [
    # (import ../../overlays/rtl8852cu.nix)
    (import ../../overlays/rtw89.nix)
  ];

  nix.settings.trusted-users = [ "desktop" ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.kernel.sysctl."vm.swappiness" = 60;
  powerManagement.cpuFreqGovernor = "performance";

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
