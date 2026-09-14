#!/bin/bash
set -e

echo "== Remote Support Setup (Tailscale) =="
echo ""
echo "This script installs Tailscale and connects this device to a private"
echo "remote-support network so it can be reached for troubleshooting."
echo "You can remove it at any time by running:"
echo "    sudo tailscale down"
echo "    sudo /Applications/Tailscale.app/Contents/MacOS/Tailscale --uninstall"
echo ""

read -rp "Enter the auth key you were given (starts with tskey-auth-): " AUTHKEY

if [[ -z "$AUTHKEY" ]]; then
  echo "No auth key entered. Aborting."
  exit 1
fi

echo ""
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo ""
echo "Connecting to the remote-support network..."
sudo tailscale up --authkey="$AUTHKEY" --ssh

echo ""
echo "Done. This device is now reachable over Tailscale SSH."
echo "Device name on the network:"
tailscale status --self=true 2>/dev/null | head -n1 || true
