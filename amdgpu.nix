# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  # AMD Gpu 
  boot.initrd.kernelModules = [ "amdgpu" ];
  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    rocm-opencl-icd
    rocm-opencl-runtime
   # amdvlk
  ];
  # AMDvlk For 32 bit applications
  #hardware.opengl.extraPackages32 = with pkgs; [
  #  driversi686Linux.amdvlk
  #];
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  #wayland specific apps
  #environment.systemPackages = with pkgs; [
  #  rofi-wayland
  #];

}

