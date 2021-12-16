. ../utils.sh
. ../cupCake.sh

piOverclock(){
    Step "Overclock Pi" &&
    overclockPi /boot/config.txt
}

updateDistro(){
    Step "Syncronize DB and update system" &&
    sudo apt -y update &&
    sudo apt -y full-upgrade
}

installBasics(){
    Step "Install basic utilities" &&
    sudo apt -y install htop neofetch preload timeshift bleachbit stacer
}

installCode(){
    Step "Install MS Code" &&
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg &&
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ &&
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' &&
    rm -f packages.microsoft.gpg &&
    sudo apt -y update &&
    sudo apt -y install apt-transport-https code
}

installNode(){
    Step "Install node, npm & yarn" &&
    sudo apt -y install nodejs npm code &&
    sudo npm install --global yarn
}

cleanUp(){
    Step "Execute a cleanup" &&
    sudo apt -y autoremove &&
    sudo apt clean
}

Run $0 'askSudo piOverclock updateDistro installBasics installCode installNode cleanUp'
