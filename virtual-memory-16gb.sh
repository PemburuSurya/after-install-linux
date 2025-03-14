#!/bin/bash

# Nonaktifkan semua swap yang sedang aktif
sudo swapoff -a

# Buat file swap baru sebesar 16 GB
sudo fallocate -l 16G /swapfile

# Atur izin file swap agar hanya dapat diakses oleh root
sudo chmod 600 /swapfile

# Format file sebagai swap
sudo mkswap /swapfile

# Aktifkan file swap
sudo swapon /swapfile

# Set overcommit memory ke 1 (untuk mengizinkan alokasi memori lebih dari yang tersedia)
sudo sysctl -w vm.overcommit_memory=1

# Simpan pengaturan overcommit memory secara permanen
echo 'vm.overcommit_memory=1' | sudo tee -a /etc/sysctl.conf

# Verifikasi swap dan overcommit memory
echo "Swap yang aktif:"
sudo swapon --show

echo "Pengaturan overcommit memory:"
cat /proc/sys/vm/overcommit_memory

echo "Setup swap 16 GB dan overcommit memory selesai!"
