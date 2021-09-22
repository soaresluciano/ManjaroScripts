#!/bin/sh

sudo echo "Setup for Manjaro minimal"
sudo pacman-mirrors --continent 
sudo pacman -Syu

#Xorg and drivers
sudo pacman -S --needed xorg-server xorg-server-common xorg-xinit

#Network utilities
sudo pacman -S --needed tigervnc netctl ifplugd iw wpa_supplicant dialog network-manager-applet networkmanager-openvpn

#KDE
sudo pacman -S --needed plasma-meta
sudo systemctl enable sddm.service --force

#Utilities
sudo pacman -S --needed yay git neofetch htop base-devel

#Reboot
sudo systemctl reboot
