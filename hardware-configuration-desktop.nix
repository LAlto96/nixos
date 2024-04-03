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
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ce6cd304-0c24-4164-bf0a-ec8eb8d0623b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-b636108b-c002-4241-8490-8d7f2b45ba0a".device = "/dev/disk/by-uuid/b636108b-c002-4241-8490-8d7f2b45ba0a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EF0B-31A6";
      fsType = "vfat";
    };

  fileSystems."/mnt/homeback" =
    { device = "/dev/disk/by-uuid/af9f3ce1-a071-4ad8-92ef-cf195002ea76";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-84736376-3af5-4f0a-a92b-0b97ad71709f".device = "/dev/disk/by-uuid/84736376-3af5-4f0a-a92b-0b97ad71709f";

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/323ce481-302f-4675-89a9-ca0b1971d8f2";
      fsType = "ext4";
    };

  fileSystems."/mnt/4to" =
    { device = "/dev/disk/by-uuid/8500bd1f-2304-4981-b32e-a2f4560a2597";
      fsType = "ext4";
    };

    swapDevices = [{
      device = "/var/lib/swapfile";
      size = 8*1024;
    }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-10481640dd8e.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-153787c30c2c.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-3704421c8530.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-5a18d0c28467.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-c2879dd3105b.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth0cd0067.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
