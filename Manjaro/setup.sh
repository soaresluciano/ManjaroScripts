#!/bin/sh

sudo echo "Setup for Manjaro minimal"
sudo pacman-mirrors --continent 
sudo pacman -Syyu

sudo pacman -S --needed yay git neofetch htop
