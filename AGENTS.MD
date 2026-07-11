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

## Verification Policy

Prefer static inspection first: read the relevant files, search with `rg`, and
review the diff. Do not run Nix evaluation or build commands by default.

Commands such as `nix flake show`, `nix flake check`, `nix build`, and every
`nixos-rebuild` mode can perform broad or expensive evaluation, even when no
build is requested explicitly.

When runtime verification is necessary:

1. Prefer a narrowly targeted `nix eval` expression or attribute.
2. Avoid evaluating an entire NixOS configuration when source inspection is
   sufficient.
3. Ask the user before running a broad or potentially long Nix evaluation or
   build.

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

- **Inspect statically first** – Read files, search with `rg`, and review diffs
- **Do not evaluate by default** – Run Nix evaluation or build commands only
  when they provide necessary verification
- **Keep evaluation targeted** – Prefer a narrow `nix eval` attribute over a
  whole-flake or whole-system evaluation
- **Treat broad commands as expensive** – This includes `nix flake show`,
  `nix flake check`, `nix build`, and every `nixos-rebuild` mode
- **Ask before expensive checks** – Get user confirmation before broad or
  potentially long evaluations and builds
- **Never switch implicitly** – Do not run `nixos-rebuild switch` unless the
  user explicitly requests it
