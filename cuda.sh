#!/bin/bash
CODENAME=$(cat /etc/*-release | grep UBUNTU_CODENAME | cut -d'=' -f 2)

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
rm cuda-keyring_1.0-1_all.deb

apt update
apt -y -f install cuda
