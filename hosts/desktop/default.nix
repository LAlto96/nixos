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

  # Avoid large temporary and persistent writes when desktop applications crash.
  systemd.coredump.settings.Coredump = {
    Storage = "none";
    ProcessSizeMax = 0;
  };

  home-manager.users.desktop = import ../../home-desktop.nix;
  home-manager.backupFileExtension = "backup";

  nix.settings.trusted-users = [ "desktop" ];

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    shutdown-timeout = 2;
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.kernel.sysctl."vm.swappiness" = 60;
  # Let periodic TRIM reach the filesystem through the encrypted root volume.
  boot.initrd.luks.devices."nvme0n1p1_crypt".allowDiscards = true;
  boot.kernelParams = [
    "nowatchdog"
  ];
  boot.blacklistedKernelModules = [ "sp5100_tco" ];
  powerManagement.cpuFreqGovernor = "performance";

  # Prefer weekly TRIM over continuous discard on file deletion.
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

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
