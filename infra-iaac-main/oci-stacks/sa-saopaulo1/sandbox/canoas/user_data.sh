#!/bin/bash

# Backup original file
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Search and replace the text
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Restart the sshd service to apply changes
sudo systemctl restart sshd

# Making the repos
mkdir /iot
mkdir /appdata

# Adding new repositories from network
echo "10.1.1.50:/appdata          /appdata        nfs defaults 0 0" >> /etc/fstab
echo "10.1.1.51:/iot              /iot            nfs defaults 0 0" >> /etc/fstab

# Upgrade the machine
sudo yum upgrade -y
