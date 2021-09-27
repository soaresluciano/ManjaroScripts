#!/bin/sh
source ~/Scripts/cupCake.sh

piOverclock() {
    Step "Overclock Pi" &&
    overclockPi /boot/config.txt
}

updateDistro () {
    Step "Syncronize DB and update system" &&
    sudo pacman-mirrors --fasttrack &&
    sudo pacman -Syyu
}

installBasics () {
    Step "Install basic utilities" &&
    sudo pacman -S --needed yay neofetch htop base-devel
}

Run $0 'askSudo piOverclock updateDistro installBasics'
