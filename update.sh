# Backup flake.lock
rm /home/laptop/Documents/nix-configuration/flake.lock
cp /etc/nixos/flake.lock /home/laptop/Documents/nix-configuration/flake.lock

# Remove content in /etc/nixos
rm -rf /etc/nixos/*
echo "Removed content in /etc/nixos"

# Copy content from ~/Documents/nix-configuration to /etc/nixos
cp -r /home/laptop/Documents/nix-configuration/* /etc/nixos/
# Remove update.sh from /etc/nixos
rm /etc/nixos/update.sh
echo "Copied content from ~/Documents/nix-configuration to /etc/nixos"

rm /home/laptop/Documents/nix-configuration/flake.lock

# Update NixOS
cd /etc/nixos && nix flake update && nixos-rebuild switch --flake .#laptop --show-trace