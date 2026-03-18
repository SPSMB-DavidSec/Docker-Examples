#!/bin/sh

set -e

echo "Updating package index..."
apt-get update

echo "Installing dependencies..."
apt-get install -y ca-certificates curl gnupg

echo "Creating keyrings directory..."
install -m 0755 -d /etc/apt/keyrings

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list

echo "Updating package index again..."
apt-get update

echo "Installing Docker..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installation complete!"
docker --version
