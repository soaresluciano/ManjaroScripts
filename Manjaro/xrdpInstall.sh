#!/bin/sh
source ~/Scripts/utils.sh
source ~/Scripts/cupCake.sh

installPackages (){
    Step "Install packages" &&
    yay -S xrdp xorgxrdp
}

XwrapperConfig (){
    local file=/etc/X11/Xwrapper.config

    Step "Configuring Xwrapper.config" &&
    backup $file &&
    appendTo $file "allowed_users=anybody"
}

xinitrc (){
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
    Step "Checcking the services status" &&
    echo "sudo systemctl status xrdp" &&
    sudo "sudo systemctl status xrdp-sesman.service"
}

myIp (){
    Step "Checking Ip address" &&
    ip a
}

Run $0 'askSudo installPackages XwrapperConfig xrdpinitrcConfig servicesStatus myIp'
