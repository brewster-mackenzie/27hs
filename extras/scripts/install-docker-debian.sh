#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verfiy the installation
docker --version
sudo docker run hello-world

# Create docker group and add user to it
sudo groupadd docker
sudo usermod -aG docker $USER

# Start docker service
sudo systemctl enable docker
sudo systemctl start docker

# Install additional tools
sudo apt-get install pwgen

echo "INSTALLATION FINISHED"
echo "The user '$USER' has been added to the 'docker' group"
echo "Please logout and login again to ensure correct permissions"

