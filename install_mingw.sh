#!/bin/sh

# update and upgrade
sudo apt update
sudo apt upgrade -y

# install packages
sudo apt install -y gfortran-mingw-w64-x86-64

# re-check and cleanup
sudo apt upgrade -y --fix-missing
sudo apt autoremove -y
