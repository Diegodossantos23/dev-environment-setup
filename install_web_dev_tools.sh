echo "Updating package list and installing essential tools..."
sudo apt-get update
sudo apt-get install -y curl wget htop

echo "Installing Google Chrome..."
if ! dpkg -l | grep -q "google-chrome-stable"; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome is already installed."
fi

echo "Installing Visual Studio Code..."
if ! command -v code &>/dev/null; then
    sudo snap install --classic code
else
    echo "Visual Studio Code is already installed."
fi

echo "Installing Node.js and npm..."
if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
    sudo apt-get install -y nodejs npm
else
    echo "Node.js and npm are already installed."
fi

echo "Installing Git..."
if ! command -v git &>/dev/null; then
    sudo apt-get install -y git
else
    echo "Git is already installed."
fi

echo "Installing Postman..."
if ! snap list | grep -q "postman"; then
    sudo snap install postman
else
    echo "Postman is already installed."
fi

echo "Installing Docker..."
if ! command -v docker &>/dev/null; then
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
else
    echo "Docker is already installed."
fi

echo "Installing Docker Compose..."
if ! command -v docker-compose &>/dev/null; then
    sudo apt-get install -y docker-compose
else
    echo "Docker Compose is already installed."
fi

echo "Installing Apache2..."
if ! dpkg -l | grep -q "apache2"; then
    sudo apt install apache2
    sudo systemctl status apache2
else
    echo "Apache2 is already installed."
fi

echo "Installing PostgreSQL..."
if ! dpkg -l | grep -q "postgresql"; then
    sudo apt-get install -y postgresql
else
    echo "PostgreSQL is already installed."
fi

echo "Installation completed."
