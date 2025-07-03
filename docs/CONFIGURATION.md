# Configuration Overview

This document provides a detailed explanation of the structure and options used in this NixOS configuration repository.


## Flake Structure

The root `flake.nix` defines inputs for various channels such as `nixpkgs`, `home-manager`, `stylix` and others. Two main NixOS configurations are declared:

- **laptop** – targets laptops with modules imported from `hardware-configuration-laptop.nix` and user specific settings defined in `home-laptop.nix`.
- **desktop** – desktop configuration using `hardware-configuration-desktop.nix` with user settings from `home-desktop.nix`.

Each configuration pulls in common modules like `configuration.nix`, GPU configuration files, and Home Manager.

The shared pieces are defined in `common-modules.nix`. This file imports the
main `configuration.nix`, the Stylix theming module and the Home Manager NixOS
module with `useGlobalPkgs` disabled and `useUserPackages` enabled. It also sets
`virtualisation.docker.enable = true` and applies overlays such as
`hyprpanel.overlay`. Both hosts include this list of modules via the flake so
they start from the same base configuration.

## Core System Configuration (`configuration.nix`)

This file is the heart of the system configuration. Key areas include:

1. **Imports** – brings in other modules such as custom packages from `packages/common.nix`.
2. **Hardware & Virtualization** – enables virtualbox, libvirtd, Logitech device support, and other hardware options. ZRAM swap is also activated. Bluetooth is enabled only for the laptop host. Additional udev rules grant Wolf virtual input devices access to `/dev/uinput` and place them on seat9.
3. **Boot Settings** – systemd-boot with EFI support, kernel modules (e.g., `v4l2loopback`), and plymouth splash.
4. **Security** – enabling policykit and realtime kit.
5. **Networking** – hostname, firewall defaults, wireless support, and NetworkManager.
6. **Locale & Time** – timezone `Europe/Paris` with English locales.
7. **Console and X11** – keeps the French keyboard layout while the system language is English.
8. **Fonts** – installs a selection of fonts including JetBrains Mono and Noto packages.
9. **Users** – defines `laptop` and `desktop` users with group memberships, including the `input` group so they can use Wolf's virtual devices.
10. **Nix Settings** – allows unfree packages, sets flake registry, and configures nix path.
11. **Environment** – sets global environment variables and enables Zsh.
12. **Services** – enables Flatpak, Udisks2, Emacs daemon, XDG portals, and the
    Tailscale VPN service.
13. **Programs** – Hyprland, KDE Connect, Gamemode, Yazi file manager with custom keymap, CoreCtrl for hardware control, and more. Hyprland also launches Hyprpanel (themes in `hyprpanel_themes/`) and the `hyprsunset.sh` script. The hyprsunset daemon itself runs as a systemd user service to adjust the screen temperature based on sunrise and sunset times.
14. **Audio** – uses Pipewire with PulseAudio disabled.
15. **Stylix** – manages desktop theming and fonts.
16. **System Maintenance** – placeholder for garbage collection settings.
17. **State Version** – system.stateVersion is set to `23.05`.

## Home Manager Modules

User environments are managed with Home Manager:

- `home-desktop.nix` – sets up the `desktop` user, including Git configuration, Neovim setup, OBS Studio plugins, and window manager configuration from `wm-desktop`.
- `home-laptop.nix` – similar for the `laptop` user but with different package selections and window manager settings from `wm-laptop`.

Both import shared modules under `hm/` such as Zsh, Neovim, and VSCode configurations.

### Zsh Aliases

The shared Zsh module (`hm/zsh.nix`) defines several handy shortcuts:

| Alias               | Command |
|---------------------|---------|
| `doom`              | `/home/desktop/.config/emacs/bin/doom` |
| `dupdate`           | `sudo nixos-rebuild switch --flake ~/Documents/nix-configuration#desktop --show-trace` |
| `lupdate`           | `sudo nixos-rebuild switch --flake ~/Documents/nix-configuration#laptop --show-trace` |
| `v4l2loopback-ctl0` | `nix-shell -p linuxKernel.packages.linux_zen.v4l2loopback --run 'v4l2loopback-ctl set-caps /dev/video0 "YU12:1280x720" && sudo v4l2loopback-ctl set-fps /dev/video0 60'` |
| `v4l2loopback-ctl1` | `nix-shell -p linuxKernel.packages.linux_zen.v4l2loopback --run 'v4l2loopback-ctl set-caps /dev/video1 "YU12:1280x720" && sudo v4l2loopback-ctl set-fps /dev/video1 60'` |
| `skb`               | `hyprctl switchxkblayout htltek-gaming-keyboard next` |
| `extract`           | `~/extract.sh` |
| `dpms`              | `hyprctl dispatch dpms off && sleep 2 && hyprctl dispatch dpms on` |
| `4000`              | `hyprctl hyprsunset temperature 40000` |
| `identity`          | `hyprctl hyprsunset identity` |

On the laptop host, additional aliases are defined in `home-laptop.nix`:

| Alias | Command         |
|-------|-----------------|
| `ac`  | `sudo tlp ac`    |
| `bat` | `sudo tlp start` |

## Hardware Configuration Files

- `hardware-configuration.nix` – base hardware config used by default.
- `hardware-configuration-desktop.nix` – disk and device setup for the desktop machine, including multiple mount points.
- `hardware-configuration-laptop.nix` – laptop-specific disk layout and modules.

These files are generated by `nixos-generate-config` and describe filesystems, swap devices, and DHCP settings.

## GPU Modules

Two optional modules configure graphics drivers:

- `amdgpu.nix` – loads the AMD GPU driver, sets Vulkan packages, and exposes 32‑bit libraries.
- `nvidiagpu.nix` – enables proprietary NVIDIA drivers with options like power management and nvidia-settings.

## Package Collection (`packages/common.nix`)

Custom package definitions and system-wide packages are declared here. Highlights include:

- Enabling programs such as Steam, Java, and numerous multimedia tools.
- Large list of utilities ranging from audio tools, terminal utilities, to gaming enhancements.
- Overrides for themes like Catppuccin GTK.

To add your own packages, edit `packages/common.nix` directly. Packages pulled from the
main channel are organized into several `pkgs2_*` lists near the top of the
file. Append your desired package to the appropriate group (or create a new
group) and it will be included when all lists are concatenated into
`environment.systemPackages`. Packages that should come from the alternate
`pkgs-stable` channel go into the `stablepkgs` list defined above those groups.

## Hosts Directory

Host-specific modules live under the `hosts` folder. Each subdirectory
contains a `default.nix` file that builds on the common modules and adds
machine‑specific options. Below is a summary of the two provided hosts:

- **desktop**
  - Imports `hardware-configuration-desktop.nix` and the NVIDIA GPU module.
  - Enables SDDM with auto‑login for the `desktop` user and sets Hyprland as
    the default session.
  - Reads `ports.nix` to open a large set of firewall ports:
    22, 80, 91, 443, 444, 5037, 5555, 6379, 7777, 7878, 8080, 8096, 8211,
    8501, 8777, 8989, 9100, 27015, 47984, 47989, 47990, 47998, 47999, 48000,
    48002 and 48010.

- **laptop**
  - Imports `hardware-configuration-laptop.nix` with both AMD and NVIDIA GPU
    modules.
  - Enables Bluetooth (with the Blueman applet) so the service starts automatically, and provides a 16 GiB swap
    file at `/var/lib/swapfile`.
  - Allows a small set of firewall ports: 80, 91, 443, 444, 8501 and 9100.

## Additional Modules

- `droidcam.nix` and `v4l2loopback-dc.nix` – provide DroidCam and its kernel module.
- `python.nix` – defines a set of Python packages using `pkgs.python3.withPackages`.
-  Hyprpanel is provided as an overlay through `common-modules.nix`. Themes live in `hyprpanel_themes/`.
- `hyprsunset.sh` – a script launched by Hyprland to adjust screen color automatically: 4000 K at night and `identity` during the day.
- System programs like **Yazi** and **CoreCtrl** are enabled in `configuration.nix` (see Core System Configuration, item 13).

## Adding a new host

Follow these steps to create another machine configuration:

1. Edit `<hostname>/default.nix` to match your hardware and user setup:
   - Update the `imports` list so it points to the correct hardware configuration
     and GPU modules.
   - Adjust the firewall port lists (or `ports.nix`) to open the ports you need.
   - Map the new user under `home-manager.users` and `nix.settings.trusted-users`.
2. Add the host to `flake.nix` under `nixosConfigurations` so it can be built via
   `nixos-rebuild`:

   ```nix
   hostname = nixpkgs.lib.nixosSystem {
     # ...
     modules = commonModules ++ [ ./hosts/hostname ];
   };

## Hyprland and Hyprpanel

Window manager configuration is split between a base file and host‑specific
overrides:

- `hyprland.base.conf` – common options shared by all machines.
- `wm-desktop/hyprland.conf` and `wm-laptop/hyprland.conf` – settings that apply
  only to the desktop or laptop.

Hyprland reads both files through the `wm-*/wm.nix` modules.

Hyprpanel themes are stored under `hyprpanel_themes/themes`.  The module
`hm/hyprpanel.nix` exposes options to pick a theme and adjust the panel layout or
other settings.  For example, enable the module and load one of the bundled
themes like so:

```nix
{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_frappe"; # file is hyprpanel_themes/themes/catppuccin_frappe.json
  };
}
```

Further customization is available through the `layout` and `settings` options
documented in that file.

## Hyprland and Hyprpanel

Window manager configuration is split between a base file and host‑specific
overrides:

- `hyprland.base.conf` – common options shared by all machines.
- `wm-desktop/hyprland.conf` and `wm-laptop/hyprland.conf` – settings that apply
  only to the desktop or laptop.

Hyprland reads both files through the `wm-*/wm.nix` modules.

Hyprpanel themes are stored under `hyprpanel_themes/themes`.  The module
`hm/hyprpanel.nix` exposes options to pick a theme and adjust the panel layout or
other settings.  For example, enable the module and load one of the bundled
themes like so:

```nix
{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_frappe"; # file is hyprpanel_themes/themes/catppuccin_frappe.json
  };
}
```

Further customization is available through the `layout` and `settings` options
documented in that file.

## Hyprland and Hyprpanel

Window manager configuration is split between a base file and host‑specific
overrides:

- `hyprland.base.conf` – common options shared by all machines.
- `wm-desktop/hyprland.conf` and `wm-laptop/hyprland.conf` – settings that apply
  only to the desktop or laptop.

Hyprland reads both files through the `wm-*/wm.nix` modules.

Hyprpanel themes are stored under `hyprpanel_themes/themes`.  The module
`hm/hyprpanel.nix` exposes options to pick a theme and adjust the panel layout or
other settings.  For example, enable the module and load one of the bundled
themes like so:

```nix
{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_frappe"; # file is hyprpanel_themes/themes/catppuccin_frappe.json
  };
}
```

Further customization is available through the `layout` and `settings` options
documented in that file.

## Hyprsunset Script

The repository includes a small helper script `hyprsunset.sh`. It queries the
[sunrisesunset.io](https://sunrisesunset.io/) API with `curl` and `jq` to obtain
both sunrise and sunset times. Every few minutes it checks whether the current
time falls between sunset and sunrise. If so, it lowers the screen temperature
to 4000 K; otherwise it restores the `identity` temperature. Manual
temperature changes are respected: if the user sets the temperature to
`identity` while the sun is down, the script pauses until the temperature
drops again. Failed API lookups are ignored until the next interval.
Hyprsunset itself runs as a systemd user service. To launch the helper script in
Hyprland add the following line to your configuration:

```ini
exec-once = ~/Documents/nix-configuration/hyprsunset.sh
```

The script logs its actions to `~/hyprsunset.log` so you can troubleshoot any
issues that arise. The current temperature is determined by reading the latest
"Received a request" entry from the hyprsunset systemd journal.

Dependencies: `curl` and `jq` need to be available.

## Hypridle

Hypridle runs as a user service and monitors inactivity. The bundled
`hypridle.conf` locks the session after 5 minutes and powers off the display
after 6 minutes. The configuration is installed to
`~/.config/hypr/hypridle.conf` for each user and the service itself is enabled
in `configuration.nix`.

## Laptop HDMI monitor configuration

When a second monitor is attached to the laptop via HDMI, Hyprland automatically
places it on the right side of the built-in display. Workspaces 6–10 are mapped
to this output so that they appear on the external screen whenever it is
present. The full configuration is available in `wm-laptop/hyprland.conf`.

## Tailscale VPN

Both hosts have `services.tailscale.enable = true` in the system
configuration. After rebuilding, use `sudo tailscale up --auth-key=<KEY>`
to authenticate the machine and join your Tailnet. Generate a key from the
Tailscale admin console.

## Adding a new host

Follow these steps to create another machine configuration:

1. Edit `<hostname>/default.nix` to match your hardware and user setup:
   - Update the `imports` list so it points to the correct hardware configuration
     and GPU modules.
   - Adjust the firewall port lists (or `ports.nix`) to open the ports you need.
   - Map the new user under `home-manager.users` and `nix.settings.trusted-users`.
2. Add the host to `flake.nix` under `nixosConfigurations` so it can be built via
   `nixos-rebuild`:

   ```nix
   hostname = nixpkgs.lib.nixosSystem {
     # ...
     modules = commonModules ++ [ ./hosts/hostname ];
   };
   ```

## Hyprland and Hyprpanel

Window manager configuration is split between a base file and host‑specific
overrides:

- `hyprland.base.conf` – common options shared by all machines.
- `wm-desktop/hyprland.conf` and `wm-laptop/hyprland.conf` – settings that apply
  only to the desktop or laptop.

Hyprland reads both files through the `wm-*/wm.nix` modules.

Hyprpanel themes are stored under `hyprpanel_themes/themes`.  The module
`hm/hyprpanel.nix` exposes options to pick a theme and adjust the panel layout or
other settings.  For example, enable the module and load one of the bundled
themes like so:

```nix
{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_frappe"; # file is hyprpanel_themes/themes/catppuccin_frappe.json
  };
}
```

Further customization is available through the `layout` and `settings` options
documented in that file.

## Adding a new host

Follow these steps to create another machine configuration:

1. Edit `<hostname>/default.nix` to match your hardware and user setup:
   - Update the `imports` list so it points to the correct hardware configuration
     and GPU modules.
   - Adjust the firewall port lists (or `ports.nix`) to open the ports you need.
   - Map the new user under `home-manager.users` and `nix.settings.trusted-users`.
2. Add the host to `flake.nix` under `nixosConfigurations` so it can be built via
   `nixos-rebuild`:

   ```nix
   hostname = nixpkgs.lib.nixosSystem {
     # ...
     modules = commonModules ++ [ ./hosts/hostname ];
   };
   ```


---

This documentation aims to serve as a reference for understanding and extending the configuration.
