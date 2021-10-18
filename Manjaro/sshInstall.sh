#!/bin/sh
source ../utils.sh
source ../cupCake.sh

installPackages(){
    Step "Install packages" &&
    sudo pacman -S --needed fail2ban
}

fail2banConfig(){
    local destination=/etc/fail2ban/jail.d/sshd.local
    Step "Configuring fail2ban" &&
    overwrite ./sshd.local $destination
}

enableFail2ban(){
    Step "Enabling the fail2ban" &&
    systemctl enable fail2ban.service
}

serviceConfig(){
    local file=/etc/ssh/sshd_config
    Step "Configuring service" &&
	sudo nano $file
}

reboot (){
    Step "Rebooting" &&
    sudo reboot now
}

Run $0 'askSudo installPackages serviceConfig fail2banConfig enableFail2ban reboot'
