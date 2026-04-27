# Home Manager

## Entrées par host

- `home-desktop.nix`
- `home-laptop.nix`

## Modules partagés importés

- `hm/vscode.nix`
- `hm/zsh.nix`
- `hm/neovim.nix`
- un module WM (`wm-desktop/wm.nix` ou `wm-laptop/wm.nix`)

## Fichiers déployés

Les deux profils déploient notamment:

- configs Doom Emacs
- configs btop
- configs YouTube Music
- `hypridle.conf` et `hyprlock`
- fichiers hyprpanel

## Différences principales

| Sujet | desktop | laptop |
|---|---|---|
| Package utilisateur spécifique | - | `moonlight-qt` |
| Alias zsh host | `valheim` | `ac`, `bat` |
| Signature git | non forcée | `signing.format = openpgp` |
