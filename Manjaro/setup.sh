#!/bin/sh
source ../cupCake.sh

updateDistro(){
    Step "Syncronize DB and update system" &&
    sudo pacman-mirrors --geoip &&
    sudo pacman -Syu
}

installBasics(){
    Step "Install basic utilities" &&
    sudo pacman -S --needed yay neofetch htop base-devel
}

piOverclock(){
    Step "Overclock Pi" &&
    overclockPi /boot/config.txt
}

Run $0 'askSudo piOverclock updateDistro installBasics'
