# Remove content in /etc/nixos
rm -rf /etc/nixos/*
echo "Removed content in /etc/nixos"

# Copy content from ~/Documents/nix-configuration to /etc/nixos
# cp -r /home/laptop/Documents/nix-configuration/* /etc/nixos/
cp -r /home/desktop/Documents/nix-configuration/* /etc/nixos/
# Remove update.sh from /etc/nixos
rm /etc/nixos/update.sh
echo "Copied content from ~/Documents/nix-configuration to /etc/nixos"

# Update NixOS
cd /etc/nixos && nixos-rebuild switch --flake .#desktop --show-trace
