{ config, ... }:
{

  boot.kernelModules = [ "8852cu" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8852cu ];
}
