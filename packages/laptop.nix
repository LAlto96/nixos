{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
