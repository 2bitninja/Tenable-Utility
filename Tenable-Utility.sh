#!/bin/bash
# Tenable-Utility: A script for managing administrative tasks in Tenable.sc and Nessus.
# Created: 20221031
# Author: 2bitninja
# Description: This utility helps to manage user accounts in Tenable.sc and Nessus, 
# including locking, unlocking, and password resets, as well as adding and removing Nessus users.
# Incorporated Tenable-password-reset.sh and Tenable-check-users.sh into this script.

### Variables Section ###
BOLD='\033[1m'
RED='\e[1;31m'
ENDCOLOR='\033[0m'
DB=/opt/sc/support/bin/sqlite3
PASSW="'943807ff8e7f4735e2a4774f0cf9ceec1044889088737759ef1f329beb40de00107446dffa66fdcc3d557c1b5109800b8f5083cd4e6cd018c5739135f9ceeb12'"
SALT="'e+xmTMivzO0Jmyl3XLcDIKcnXOWaKYzWCRRJu2ebr41K8sHJjtYy7JGJwR3IfohbFLUHWzVlivXtt8Dn/ok2tg=='"

### Functions Section ###

# Pauses script execution until user presses Enter
pause(){
  read -p "Press [Enter] to continue..."
}

# Displays current status of user accounts in Tenable.sc
SHOW(){
  clear
  #echo -e "$scver"
  #echo -e "Current status of accounts in Tenable.sc"
  #$DB -column -header /opt/sc/application.db "select ID,username,locked from UserAuth;"
}

# Gets the version number of Tenable.sc
get_tenable_sc_version() {
  if [ -f "$DB" ]; then
    VERSION=$(rpm -qf /opt/sc/ 2>/dev/null | sed -e 's/\-19.el7.x86_64//' -e 's/-/ /')
    echo "$VERSION"
  else
    echo "Not installed"
  fi
}

# Gets the version number of Nessus
get_nessus_version() {
  if [ -f "/opt/nessus/sbin/nessuscli" ]; then
    VERSION=$(/opt/nessus/sbin/nessuscli -v)
    echo "$VERSION"
  else
    echo "Not installed"
  fi
}

# Displays installation status of Tenable.sc and Nessus with version numbers
display_installation_status() {
  local sc_version
  local nessus_version

  sc_version=$(get_tenable_sc_version)
  nessus_version=$(get_nessus_version)

  echo -e "Tenable.sc:\t ${sc_version}"
  echo -e "Nessus:\t\t ${nessus_version}"
}

# Displays a welcome message
display_welcome_message() {
  clear
  echo -e "${BOLD}==============================================${ENDCOLOR}"
  echo -e "${BOLD}          Welcome to the Tenable Utility      ${ENDCOLOR}"
  echo -e "${BOLD}          Script for Managing Tenable.sc     ${ENDCOLOR}"
  echo -e "${BOLD}            and Nessus User Accounts         ${ENDCOLOR}"
  echo -e "${BOLD}==============================================${ENDCOLOR}\n"
  echo -e "${BOLD}      This script helps you manage user ${ENDCOLOR}"
  echo -e "${BOLD}     accounts in Tenable.sc and Nessus.${ENDCOLOR}\n"
}


#### Account Management Functions ####

# Unlocks the admin account
unlock_admin(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then
    $DB /opt/sc/application.db "UPDATE UserAuth SET locked='false' WHERE id=1"
    echo "Admin account unlocked."
  else
    echo "Tenable.sc is not installed, unable to unlock admin account."
  fi
  pause
}

# Unlocks all user accounts
unlock_all(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then    
     $DB /opt/sc/application.db "UPDATE UserAuth SET locked='false'"
     echo "All user accounts unlocked."
  else
    echo "Tenable.sc is not installed, unable to unlock all accounts."
  fi
  pause
}

# Unlocks a specific user account
unlock_user(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then    
     read -p "Enter User ID to unlock: " ID
     $DB /opt/sc/application.db "UPDATE UserAuth SET locked='false' WHERE id=$ID"
     echo "User ID $ID unlocked."
  else
    echo "Tenable.sc is not installed, unable to unlock all accounts."
  fi
  pause
}

# Locks the admin account
lock_admin(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then 
     $DB /opt/sc/application.db "UPDATE UserAuth SET locked='true' WHERE id=1"
    echo "Admin account locked."
   else
    echo "Tenable.sc is not installed, unable to lock admin account."
   fi
   pause
}

# Locks all user accounts
lock_all(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then 
     $DB /opt/sc/application.db "UPDATE UserAuth SET locked='true'"
     echo "All user accounts locked."
  else
    echo "Tenable.sc is not installed, unable to lock all accounts."
  fi
  pause
}

# Locks a specific user account
lock_user(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then 
     read -p "Enter User ID to lock: " ID
     $DB /opt/sc/application.db "UPDATE UserAuth SET locked='true' WHERE id=$ID"
     echo "User ID $ID locked."
  else
    echo "Tenable.sc is not installed, unable to lock all accounts."
  fi
  pause
}

# Resets a user's password to 'password'
reset_password(){
  if [ "$TENABLE_SC_INSTALLED" = true ]; then 
     read -p "Enter username to reset password: " TSCuser
     echo "Password reset to 'password'. Please change it after login."
     $DB /opt/sc/application.db "UPDATE UserAuth SET password=$PASSW, salt=$SALT, hashtype=2 WHERE username='$TSCuser';"
  else
    echo "Tenable.sc is not installed, unable to reset password."
  fi
  pause
}

#### Nessus Management Functions ####

# Adds a Nessus user
add_nessus_user(){
  read -p "Enter Nessus username to add: " Nusername
  /opt/nessus/sbin/nessuscli adduser $Nusername
  echo "Nessus user $Nusername added."
  pause
}

# Removes a Nessus user
remove_nessus_user(){
  read -p "Enter Nessus username to remove: " Nusername
  /opt/nessus/sbin/nessuscli rmuser $Nusername
  echo "Nessus user $Nusername removed."
  pause
}

# Changes a Nessus user's password
change_nessus_password(){
  read -p "Enter Nessus username to change password: " Nusername
  /opt/nessus/sbin/nessuscli chpasswd $Nusername
  echo "Password for Nessus user $Nusername changed."
  pause
}

# Manages Nessus user accounts (menu-based)
manage_nessus(){
  ## Commit out the if statement and the else statement, to test this section of script on a system without Nessus installed
  if [ "$NESSUS_INSTALLED" = true ]; then
    while true; do
      clear
      # Display the list of Nessus users before showing the menu
      echo -e "\n${BOLD} These are the users on the Nessus scanner${ENDCOLOR}"
      /opt/nessus/sbin/nessuscli lsuser
      
      # Show Nessus User Management menu
      echo -e "\n${BOLD}Nessus User Management${ENDCOLOR}"
      echo -e "1. Add user    | 3. Change password"
      echo -e "2. Remove user | 4. Exit\n"
    
      read -p "Choose an option [1-4]: " option
      case $option in
        1) add_nessus_user ;;
        2) remove_nessus_user ;;
        3) change_nessus_password ;;
        q|e|[Ee]xit|4) break ;;
        *) echo -e "${RED}Invalid choice.${ENDCOLOR}" && sleep 1 ;;
      esac
    done
  else
    echo "Sorry, Nessus is not installed"
    read -p "Press [Enter] to continue..."
  fi
}

#### Main Menu Functions ####

# Displays the main menu options
show_main_menu(){
  display_welcome_message
  display_installation_status
  echo -e "\n\t\t${BOLD}Tenable-Utility Menu${ENDCOLOR}"
  echo -e "1. Unlock admin account | 4. Lock admin account"
  echo -e "2. Unlock all accounts  | 5. Lock all accounts"
  echo -e "3. Unlock one account   | 6. Lock one account"
  echo -e " "
  echo -e "7. Reset user password  | 8. Manage Nessus accounts"
  echo -e "9. Exit program"
}

# Handles the main menu selection
read_main_menu_option(){
  local choice
  read -p "Enter choice [1-9]: " choice
  case $choice in
    1) unlock_admin ;;
    2) unlock_all ;;
    3) unlock_user ;;
    4) lock_admin ;;
    5) lock_all ;;
    6) lock_user ;;
    7) reset_password ;;
    8) manage_nessus ;;
    q|e|[Ee]xit|9) exit 0 ;;
    *) echo -e "${RED}Invalid choice, please try again.${ENDCOLOR}" && sleep 1 ;;
  esac
}

### Script Execution Starts Here ###

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Check if Tenable.sc is installed
if [ ! -f "$DB" ]; then
  echo "Tenable.sc is not installed on this system."
  TENABLE_SC_INSTALLED=false
else
  TENABLE_SC_INSTALLED=true
fi

# Check if Nessus is installed
if [ ! -f "/opt/nessus/sbin/nessuscli" ]; then
  echo "Nessus is not installed on this system."
  NESSUS_INSTALLED=false
else
  NESSUS_INSTALLED=true
fi

# Main menu loop
while true; do
  SHOW
  show_main_menu
  read_main_menu_option
done
