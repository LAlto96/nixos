# Services

## Services système (socle commun)

| Service | État |
|---|---|
| `services.tailscale` | activé |
| `services.flatpak` | activé |
| `services.udisks2` | activé |
| `services.emacs` | activé |
| `services.dbus` | activé |
| `services.hypridle` | activé |

## Services par host

### Desktop

- `services.openssh.enable = true`
- `services.openssh.ports = [ 2268 ]`
- `virtualisation.docker.enable = true`
- `virtualisation.libvirtd.enable = true`

### Laptop

- `services.blueman.enable = true`
- `services.tlp.enable = true` (via `tlp.nix`)
