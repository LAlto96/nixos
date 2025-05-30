# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ce6cd304-0c24-4164-bf0a-ec8eb8d0623b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-b636108b-c002-4241-8490-8d7f2b45ba0a".device = "/dev/disk/by-uuid/b636108b-c002-4241-8490-8d7f2b45ba0a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EF0B-31A6";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/4to" =
    { device = "/dev/disk/by-uuid/8500bd1f-2304-4981-b32e-a2f4560a2597";
      fsType = "ext4";
    };

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/323ce481-302f-4675-89a9-ca0b1971d8f2";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-74e4756b4c1c.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp43s0f3u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.vboxnet0.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethb11bd43.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp43s0f3u3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
