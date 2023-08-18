if [ "$1" != "laptop" -a "$1" != "desktop" ]
then
	echo "Argument attendu : 'laptop' ou 'desktop'"
	exit 1
else
	# Remove content in /etc/nixos
	rm -rf /etc/nixos/*
	echo "Removed content in /etc/nixos"

	# Copy content from ~/Documents/nix-configuration to /etc/nixos
	cp -r /home/$1/Documents/nix-configuration/* /etc/nixos/
	echo "NixOS configuration copied to /etc/nixos"

	# Remove update.sh from /etc/nixos
	rm /etc/nixos/update.sh
	echo "Removed update.sh from /etc/nixos"

	# Update NixOS
	cd /etc/nixos && nixos-generate-config && nixos-rebuild switch --flake .#$1 --show-trace
fi



