# Remove content in /etc/nixos
rm -rf /etc/nixos/*
echo "Removed content in /etc/nixos"

# Copy content from ~/Documents/nix-configuration to /etc/nixos
cp -r /home/laptop/Documents/nix-configuration/* /etc/nixos/
echo "Copied content from ~/Documents/nix-configuration to /etc/nixos"
