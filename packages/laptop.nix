{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Laptop-specific packages can be added here
  ];
}
