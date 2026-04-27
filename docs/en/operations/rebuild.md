# Rebuild

| Mode | Command |
|---|---|
| Preview | `sudo nixos-rebuild dry-activate --flake .#desktop` |
| Temporary | `sudo nixos-rebuild test --flake .#desktop` |
| Permanent | `sudo nixos-rebuild switch --flake .#desktop` |
| Next boot | `sudo nixos-rebuild boot --flake .#desktop` |
