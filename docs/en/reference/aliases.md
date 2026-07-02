# Aliases

This repository defines shared aliases in `hm/zsh.nix` and host-specific aliases in `home-desktop.nix` / `home-laptop.nix`.

## Shared aliases (`hm/zsh.nix`)

| Alias | Command |
|---|---|
| `nd` | runs `nix develop -c zsh` to enter a Nix dev shell while keeping zsh |

## direnv

To automatically load a flake in a repository:

```sh
echo "use flake" > .envrc
direnv allow
```
