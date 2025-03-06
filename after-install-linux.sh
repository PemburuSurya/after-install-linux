#!/bin/bash

# Update dan upgrade sistem
echo "Memperbarui dan mengupgrade sistem..."
sudo apt update && sudo apt upgrade -y

# Instal paket yang diperlukan untuk Docker
echo "Menginstal dependensi Docker..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Tambahkan kunci GPG Docker
echo "Menambahkan kunci GPG Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Tambahkan repositori Docker
echo "Menambahkan repositori Docker..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update ulang dan instal Docker
echo "Menginstal Docker..."
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Tambahkan pengguna saat ini ke grup Docker
echo "Menambahkan pengguna ke grup Docker..."
sudo usermod -aG docker $USER

# Instal berbagai alat pengembangan dan utilitas
echo "Menginstal alat-alat pengembangan dan utilitas..."
sudo apt install curl git wget htop tmux build-essential jq make gcc tar clang pkg-config libssl-dev ncdu protobuf-compiler npm nodejs flatpak default-jdk aptitude squid apache2-utils iptables iptables-persistent squid openssh-server docker-compose jq sed -y

# Instal Visual Studio Code melalui Snap
echo "Menginstal Visual Studio Code..."
sudo snap install code --classic

# Tambahkan repositori Flatpak
echo "Menambahkan repositori Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Tambahkan PPA untuk OpenJDK
echo "Menambahkan PPA OpenJDK..."
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update

# Aktifkan dan mulai layanan netfilter-persistent
echo "Mengaktifkan dan memulai netfilter-persistent..."
sudo systemctl enable netfilter-persistent
sudo systemctl start netfilter-persistent

# Instal Rust menggunakan rustup
echo "Menginstal Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Selesai
echo "Done Boy."
