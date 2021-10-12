#!/bin/sh
source ~/Scripts/utils.sh
source ~/Scripts/cupCake.sh

installPackages (){
    Step "Install packages" &&
    sudo pacman -S --needed tigervnc
}

lightdmInstall (){
    local file=/etc/lightdm/lightdm.conf
    Step "Installing lightdm" &&
    sudo pacman -S lightdm lightdm-slick-greeter &&
    backup $file &&
    replaceString $file "#greeter-session=example-gtk-gnome" "greeter-session=lightdm-slick-greeter" &&
    sudo systemctl enable lightdm.service --force
}

lightdmConfig (){
    local file=/etc/lightdm/lightdm.conf
    Step "Configuring lightdm" &&
    appendTo $file "[XDMCPServer]" &&
    appendTo $file "enabled=true" &&
    appendTo $file "port=177"
}

sddmUninstall (){
    Step "Uninstalling SDDM" &&
    sudo pacman -Rs sddm-kcm
}

socketConfig (){
    local destination=/etc/systemd/system/xvnc.socket
    Step "Configuring xvnc.socket" &&
    overwrite ./xvnc.socket $destination
}

serviceConfig (){
    local destination=/etc/systemd/system/xvnc@.service
    Step "Configuring xvnc@.service" &&
	overwrite ./xvnc@.service $destination
}

startService (){
    Step "Starting the service" &&
    systemctl enable xvnc.socket --now
}

myIp (){
    Step "Checking Ip address" &&
    ip a
}

reboot (){
    Step "Rebooting" &&
    sudo reboot now
}

Run $0 'askSudo installPackages lightdmInstall lightdmConfig sddmUninstall socketConfig serviceConfig startService myIp reboot'
