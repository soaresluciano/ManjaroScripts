#!/bin/sh

sudo echo "Setup for Manjaro minimal"
sudo pacman-mirrors --continent && sudo pacman -Syu

#Xorg and drivers
sudo pacman -S --needed xorg

#KDE
sudo pacman -S --needed sddm plasma 

#Utilities
sudo pacman -S --needed yay git neofetch htop base-devel

# Services
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

#Reboot
sudo systemctl reboot
