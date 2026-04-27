# Tailscale

Le service est activé dans la configuration commune (`services.tailscale.enable = true`).

## Joindre le tailnet

```sh
sudo tailscale up --auth-key=<VOTRE_CLE>
```

## Vérifier l'état

```sh
systemctl status tailscaled
sudo tailscale status
```

## À compléter

- Politique d'expiration des clés.
- Paramètres optionnels (`--accept-routes`, `--ssh`, tags, etc.) selon vos besoins.
