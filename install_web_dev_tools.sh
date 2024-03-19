#!/bin/bash

# Function to display progress messages
print_status() {
    echo "==> $1"
}

print_status "Updating package list..."
sudo apt update -y

print_status "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
rm google-chrome-stable_current_amd64.deb

print_status "Installing Visual Studio Code..."
sudo snap install --classic code

print_status "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs npm

print_status "Installing Git..."
sudo apt install -y git

print_status "Installing Postman..."
sudo snap install postman

print_status "Installing Docker..."
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

print_status "Installing Docker Compose..."
sudo apt-get install -y docker-compose

print_status "Installation completed."
