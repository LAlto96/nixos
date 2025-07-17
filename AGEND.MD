# Basic Repository Guidance

This repository contains NixOS configurations for both laptop and desktop hosts. The README explains how to apply a configuration.

## Actions for Codex

- **Skip full builds** – Avoid running `nixos-rebuild switch` or any command that fully builds the system, as it may fail or take too long. Use evaluation-only commands instead.
- **Run flake checks without building** – Execute `nix flake check --no-build` in the repo root to verify the flake without compiling packages.
- **Do a dry run of rebuilds** – If you want to preview changes, use `nixos-rebuild --flake .#desktop dry-activate` (or `dry-run` depending on your preferred command) instead of a full switch.
- **Show flake outputs** – Use `nix flake show` to display available outputs such as the laptop and desktop configurations before running anything else.
- **General tips**
  - Use `nix fmt` or another formatter before committing changes to `.nix` files, if available.
  - When commands fail, retry with `--show-trace` for more detail (e.g., `nixos-rebuild test --show-trace`).
