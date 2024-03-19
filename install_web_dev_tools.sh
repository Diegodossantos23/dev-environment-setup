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

echo "Installing PHP 7.1 and its extensions..."
if ! dpkg -l | grep -q "php7.1"; then
    sudo apt-get install -y python-software-properties
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install -y php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt \
        php7.1-curl php-dev php-pear \
        openssl php7.1-bcmath php7.1-json php7.1-tokenizer php7.1-zip \
        php7.1-fpm php7.1-opcache \
        php7.1-gd \
        libapache2-mod-php7.1 php7.1-soap \
        php-php-gettext \
        php7.1-pgsql
    sudo systemctl restart apache2
else
    echo "PHP 7.1 is already installed."
fi

echo "Installing PostgreSQL..."
if ! dpkg -l | grep -q "postgresql"; then
    sudo apt-get install -y postgresql
else
    echo "PostgreSQL is already installed."
fi

echo "Installation completed."
