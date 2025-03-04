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
sudo apt install docker-ce -y

# Tambahkan pengguna saat ini ke grup Docker
echo "Menambahkan pengguna ke grup Docker..."
sudo usermod -aG docker $USER

# Instal berbagai alat pengembangan dan utilitas
echo "Menginstal alat-alat pengembangan dan utilitas..."
sudo apt install curl git wget htop tmux build-essential jq make gcc tar clang pkg-config libssl-dev ncdu protobuf-compiler npm nodejs flatpak default-jdk aptitude squid apache2-utils iptables iptables-persistent squid openssh-server -y

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

# Unduh dan instal Anaconda
echo "Mengunduh dan menginstal Anaconda..."
cd /tmp
echo "Mengunduh Anaconda installer..."
curl https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh --output anaconda.sh

# Berikan izin eksekusi pada installer
chmod +x anaconda.sh

# Jalankan installer Anaconda
echo "Menginstal Anaconda..."
bash anaconda.sh -b -p $HOME/anaconda3

# Cari path anaconda3 atau miniconda3
CONDA_PATH=$(find $HOME -type d -name "anaconda3" -o -name "miniconda3" 2>/dev/null | head -n 1)

# Jika ditemukan, tambahkan ke ~/.bashrc
if [[ -n $CONDA_PATH ]]; then
    echo "Menemukan Conda di: $CONDA_PATH"
    echo ". $CONDA_PATH/etc/profile.d/conda.sh" >> ~/.bashrc
    source ~/.bashrc
    echo "Conda telah ditambahkan ke PATH."
else
    echo "Conda tidak ditemukan di sistem."
    exit 1
fi

# Periksa versi Conda
echo "Memeriksa versi Conda..."
conda --version

# Inisialisasi Conda
echo "Menginisialisasi Conda..."
conda init
source ~/.bashrc

# Install pip menggunakan Conda
echo "Menginstal pip menggunakan Conda..."
conda install pip -y

# Perbarui pip
echo "Memperbarui pip..."
pip install --upgrade pip

# Buat lingkungan virtual Python
echo "Membuat lingkungan virtual Python..."
python -m venv $HOME/myenv

# Aktifkan lingkungan virtual
echo "Mengaktifkan lingkungan virtual..."
source $HOME/myenv/bin/activate

# Selesai
echo "Instalasi selesai. Silakan logout dan login kembali untuk menerapkan perubahan grup Docker dan Conda."
echo "Lingkungan virtual Python telah diaktifkan. Gunakan 'deactivate' untuk menonaktifkannya."
