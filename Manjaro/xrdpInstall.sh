#!/bin/sh
source ~/Scripts/utils.sh
source ~/Scripts/cupCake.sh

addKey (){
    Step "Adding GPG key" &&
    gpg --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 61ECEABBF2BB40E3A35DF30A9F72CDBC01BF10EB
}

installPackages (){
    Step "Install packages" &&
    yay -S --needed xrdp xorgxrdp
}

XwrapperConfig (){
    local file=/etc/X11/Xwrapper.config

    Step "Configuring Xwrapper.config" &&
    backupOrCreate $file &&
    appendTo $file "allowed_users=anybody"
}

xinitrcConfig (){
    Step "Configuring .xinitrc" &&
    overwrite ~/Scripts/Manjaro/.xinitrc ~/.xinitrc
}

xrdpConfig (){
    local file=/etc/xrdp/xrdp.ini
    Step "Configuring xrdp.ini" &&
    backup $file &&
    replaceString $file "crypt_level=high" "crypt_level=none"
}

startServices (){
    Step "Starting the services" &&
    systemctl enable xrdp.service --now &&
    systemctl enable xrdp-sesman.service --now
}

servicesStatus (){
    Step "Checking the services status" &&
    serviceStatus xrdp.service &&
    serviceStatus xrdp-sesman.service
}

myIp (){
    Step "Checking Ip address" &&
    ip a
}

Run $0 'askSudo addKey installPackages XwrapperConfig xinitrcConfig xrdpConfig startServices servicesStatus myIp'
