#!/bin/sh
scriptName=" "
stepCont=1

Step (){
    name=$1
    title="[ STEP $stepCont: $name ]"

    echo
    echo $title

    options="Please select an option ([C]ontinue [S]kip [Q]uit): "

    while true; do
        read -n1 -p "$options"; echo

        case $REPLY in
            c | C | "")
                echo "Executing [STEP $stepCont]"
                echo
                return 0 && break
                ;;
            s | S)
                echo "Skiping [STEP $stepCont]"
                echo
                return 1 && break
                ;;
            q | Q)
                echo "Aborting the script execution"
                End
                break
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}

End (){
    echo
    echo "[CupCake :: End of the execution of script $scriptName]"
    echo
    exit 0
}

Run (){
    clear
    scriptName=$1
    echo
    echo "[CupCake :: Starting the execution of script $scriptName]"
    for step in $2
    do
        eval "$step"
        stepCont=$((stepCont+1))
    done
    End
}

askSudo () {
    Step "Elevated permission is required" &&
    echo "`sudo whoami` is in the house."
}
