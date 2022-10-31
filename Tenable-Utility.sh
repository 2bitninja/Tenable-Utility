#!/bin/bash
# Created 20221031 - Created this script to help make administrative tasks on tenable.sc easier.
# Incorporated ACAS-password-reset.sh and ACAS-check-users.sh into this script.
### VAR section
BOLD='\e[1m'
RED='\e[1;31m'
ENDCOLOR='\e[0m'
DB=/opt/sc/support/bin/sqlite3
PASSW="'943807ff8e7f4735e2a4774f0cf9ceec1044889088737759ef1f329beb40de00107446dffa66fdcc3d557c1b5109800b8f5083cd4e6cd018c5739135f9ceeb12'"
SALT="'e+xmTMivzO0Jmyl3XLcDIKcnXOWaKYzWCRRJu2ebr41K8sHJjtYy7JGJwR3IfohbFLUHWzVlivXtt8Dn/ok2tg=='"
### function section
pause(){
  read -p "Press [Enter] key to continue..."
}
# Temp place holder
work(){
echo "work in progress"
pause
}
scver=$(rpm -qf /opt/sc/ 2>/dev/null | sed -e 's/\-19.el7.x86_64//' -e 's/-/ /')
if [ -d /opt/sc/ ]
then echo -e "$scver"
else echo no
fi
# The below line shows account status
SHOW(){
clear
if [ -d /opt/sc/ ]
then echo -e "$scver"
     echo -e "${BOLD}Current status of accounts in Tenable.sc ${ENDCOLOR}"
     $DB -column -header /opt/sc/application.db "select ID,username,locked from UserAuth;"
else echo "Security Center not installed on this system"
fi
}
####
# Unlocks the admin account
unlockadmin(){
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='false' WHERE id=1"
pause
}
# Unlocks all user accounts on Tenable.sc (SecurityCenter) 
unlockAll(){
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='false'"
pause
}
# Use this line to unlock just one user.
unlockOne(){
read -p "Type ID  " ID
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='false' WHERE id=$ID"
pause
}

####
# Locks the admin account
lockadmin(){
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='true' WHERE id=1"
pause
}
# Locks all user accounts on Tenable.sc (SecurityCenter) 
lockAll(){
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='true'"
pause
}
# Use this line to lock just one user.
lockOne(){
read -p "Type ID  " ID
$DB /opt/sc/application.db "UPDATE UserAuth SET locked='true' WHERE id=$ID"
pause
}
# Password reset
resetaccount(){
read -p "Type in username: " TSCuser
echo -e "  The user's password has been set to password.\n  Please have them change it after they login."
$DB /opt/sc/application.db "update userauth set password = $PASSW, salt = $SALT , hashtype = 2 where username='$TSCuser';"
pause
}

## Nessuscli section
# Add Nessus user
AddNesUser(){
read -p "Type in desired account name:  " Nusername
/opt/nessus/sbin/nessuscli adduser $Nusername
pause
}
# Remove Nessus user
DelNesUser(){
read -p "Type in desired account name:  " Nusername
/opt/nessus/sbin/nessuscli rmuser $Nusername
pause
}
# Change Nessus user password
Nchpasswd(){
read -p "Type in username:  " npass
/opt/nessus/sbin/nessuscli chpasswd $npass
}
NesAct(){
        clear
        ShowAccounts(){
                echo -e "\n${BOLD} These are the users on the Nessus scanner${ENDCOLOR}"
                /opt/nessus/sbin/nessuscli lsuser
        }
        Nessus_menu(){
                echo -e "\n------------------------------------"
                echo -e "1. Add user    | 3. Change password"
                echo -e "2. Remove user | 4. Exit"
        }
        Nessus_read_option(){
                local CN
                read -p "Enter choice [ 1 - 4 ]: " CN
                case $CN in
                        1) AddNesUser ;;
                        2) DelNesUser ;;
                        3) Nchpasswd ;;
                        q|e|[Ee]xit|4) break ;;
                esac
        }
while true
do
        ShowAccounts
        Nessus_menu
        Nessus_read_option
clear
done
}
## Function to display menus
show_menu(){
        echo -e "------------------------------------------------ "
        echo -e "\t${BOLD}What do you want to do?${ENDCOLOR}"
        echo -e "1. Unlock admin account | 4. Lock admin account"
        echo -e "2. Unlock all accounts  | 5. Lock all accounts"
        echo -e "3. Unlock one account   | 6. Lock one account"
        echo -e " "
        echo -e "7. Reset user password | 8. Manage Nessus accounts"
        echo -e "9. Exit program"
}
read_option(){
        local choice
        read -p "Enter choice [ 1 - 9 ]: " choice
        case $choice in
                1) unlockadmin ;;
                2) unlockAll ;;
                3) unlockOne ;;
                4) lockadmin  ;;
                5) lockAll ;;
                6) lockOne ;;
                7) resetaccount ;;
                8) NesAct ;;
                q|e|[Ee]xit|9) exit 0 ;;
                *) echo -e "${RED}Error...${ENDCOLOR} " && sleep 2
        esac
}
### Main section
if [ "$EUID" -ne 0 ]
  then echo "Please run program as root"
  exit
fi
scver=$(rpm -qf /opt/sc/ 2>/dev/null | sed -e 's/\-19.el7.x86_64//' -e 's/-/ /')
if [ -d /opt/sc/ ]
then echo -e "$scver"
else echo no
fi
# shows menu
while true
do
        SHOW
        show_menu
        read_option
done

