#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config/home-manager"
HM_CHANNEL="https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz"

echo "Setting up Nix configuration..."

# Create symlink for home-manager config
if [ ! -L "$CONFIG_DIR" ]; then
    echo "Creating home-manager symlink..."
    ln -s "$(pwd)/home/rkamesh" "$CONFIG_DIR"
else
    echo "Home-manager symlink already exists"
fi

# Rebuild NixOS system
echo "Rebuilding NixOS system..."
if ! sudo nixos-rebuild switch --flake .; then
    echo "Error: Failed to rebuild NixOS system" >&2
    exit 1
fi

# Update home-manager channel
echo "Updating home-manager channel..."
nix-channel --add "$HM_CHANNEL" home-manager
nix-channel --update

# Switch home-manager configuration
echo "Switching home-manager configuration..."
if ! home-manager switch; then
    echo "Error: Failed to switch home-manager configuration" >&2
    exit 1
fi

echo "Setup completed successfully!"