. ../utils.sh
. ../xrdp_common.sh
. ../cupCake.sh

install(){
    Step "Install xrdp" &&
    sudo apt-get install xrdp -y
}

XwrapperConfig(){
    local file=/etc/X11/Xwrapper.config

    Step "Configuring Xwrapper.config" &&
    backupOrCreate $file &&
    appendTo $file "allowed_users=anybody"
}

xrdpConfig(){
    local file=/etc/xrdp/xrdp.ini
    Step "Configuring xrdp.ini" &&
    backup $file &&
    replaceString $file "crypt_level=high" "crypt_level=none"
}

sesmanConfig(){
    local file=/etc/xrdp/sesman.ini
    Step "Configuring sesman.ini" &&
    backup $file &&
    replaceString $file "KillDisconnected=false" "KillDisconnected=true" &&
    replaceString $file "DisconnectedTimeLimit=0" "DisconnectedTimeLimit=60"
}

create_polkit(){
    local file=/etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla

    Step "Create policies exceptions" &&
    backupOrCreate $file &&
    appendTo $file "[Allow Colord all Users]"
    appendTo $file "Identity=unix-user:*"
    appendTo $file "Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile"
    appendTo $file "ResultAny=no"
    appendTo $file "ResultInactive=no"
    appendTo $file "ResultActive=yes"
}

fix_ssl(){
    Step "Fix SSL Minor Issue" &&
    xrdp_fix_ssl 
}

fix_env(){
    Step "Fix ENV Minor Issue" &&
    xrdp_fix_env 
}

enable_service(){
    Step "Starting the services" &&
    xrdp_enable_service
}

Run $0 'askSudo install XwrapperConfig xrdpConfig sesmanConfig create_polkit fix_ssl fix_env enable_service'
