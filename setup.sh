#!/bin/bash

set -e

# Install packages
sudo yum -y install \
    podman \
    libvarlink-util \
    nmap-ncat

# Add podman group
sudo groupadd podman

# Add vagrant to it
sudo usermod -a -G podman vagrant

# Configure podman
sudo cp /vagrant/assets/etc-tmpfiles-podman.conf            /etc/tmpfiles.d/podman.conf
sudo cp /vagrant/assets/etc-systemd-system-io.podman.socket /etc/systemd/system/io.podman.socket

# Start podman
sudo systemctl daemon-reload
sudo systemd-tmpfiles --create
sudo systemctl enable --now io.podman.socket

# Install Nomad
sudo yum -y install unzip
curl -sS https://releases.hashicorp.com/nomad/0.10.2/nomad_0.10.2_linux_amd64.zip > nomad.zip
unzip nomad.zip
sudo install -m 0755 nomad /usr/local/bin/nomad
mkdir -p /vagrant/plugins

# Install nomad-driver-podman

podman_url="https://github.com/pascomnet/nomad-driver-podman/releases/download/v0.0.2/nomad-driver-podman_linux_amd64.tgz"
curl -sSL "$podman_url" | tar -C /vagrant/plugins -xz

# Done!
echo "Run Nomad with Podman support:"
echo " nomad agent -config /vagrant/client.hcl"
echo " nomad run /vagrant/example.nomad"

# Reboot to pick up user/group changes
sudo poweroff --reboot
