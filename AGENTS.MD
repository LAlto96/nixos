# Basic Repository Guidance

This repository contains NixOS configurations for both **laptop** and **desktop** hosts.
The `README.md` explains how to apply a configuration.

---

## Repository Layout

- `flake.nix` — main flake definition
- `flake.lock` — locked inputs
- `hosts/desktop.nix` — desktop configuration
- `hosts/laptop.nix` — laptop configuration
- `modules/` — reusable system modules

---

## Safe Commands

These commands are safe to run anytime (no full builds):

- `nix flake show`
  → Inspect outputs (desktop, laptop, modules, packages)

- `nix flake check --no-build`
  → Verify flake syntax & integrity without compiling

- `nixos-rebuild dry-activate --flake .#desktop`
  → Preview desktop changes

- `nixos-rebuild dry-activate --flake .#laptop`
  → Preview laptop changes

---

## Rebuild Modes

| Command | Description | Persistence |
|---------|-------------|-------------|
| `dry-activate` | Preview changes only | None |
| `test` | Apply temporarily | Lost on reboot |
| `switch` | Apply permanently | Immediate + updates bootloader |
| `boot` | Apply on next reboot | At next boot only |

---

## Troubleshooting

- Add `--show-trace` to any command for detailed error logs
- If rebuild fails:
  1. Run `nix flake check --no-build` to validate flake
  2. Check `git status` for untracked/dirty files
  3. Try `nix flake update` to refresh inputs
  4. Use `nixos-rebuild dry-run` to confirm what would change

---

## Developer Tips

- Run `nix fmt` (or another formatter) before committing changes to `.nix` files
- Consider enabling [pre-commit-hooks.nix](https://github.com/cachix/pre-commit-hooks.nix)
  for automatic formatting and flake checks on commits

---

## Actions for Codex

- **Skip full builds** – Do not run `nixos-rebuild switch` directly
- **Use evaluation-only commands** – Prefer `flake check` and `flake show`
- **Preview changes safely** – Use `dry-activate` instead of full apply
- **Show flake outputs first** – Run `nix flake show` before any rebuild attempts
