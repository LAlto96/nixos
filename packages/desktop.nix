{ pkgs, ... }:

let
  # 3.1: Digital Audio Workstations (DAWs)
  pkgs3_1 = with pkgs; [
    reaper              # Main DAW application
    yabridge            # Bridges Windows plugins
    yabridgectl         # CLI helper for yabridge
  ];

  # 3.2: Video Editing
  pkgs3_2 = with pkgs; [
    davinci-resolve     # Professional video editor
  ];

  # 3.2: Virtualization
  pkgs3_3 = with pkgs; [
    qemu
    quickemu
    quickgui
  ];

in
{
  environment.systemPackages =
    pkgs3_1 ++
    pkgs3_2 ++
    pkgs3_3;
}
