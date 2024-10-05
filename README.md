# Tenable-Utility
Tenable-Utility is a bash script designed to streamline administrative tasks for Tenable.sc and Nessus. It includes functions to manage user accounts, lock/unlock users, reset passwords, and perform various operations on Nessus user accounts.
## Features
- Unlock or lock the admin or all user accounts in Tenable.sc.
- Unlock or lock a specific user by providing their user ID.
- Reset the password for a Tenable.sc user to a predefined value.
- Manage Nessus user accounts:
    - Add a new Nessus user.
    - Remove an existing Nessus user.
    - Change a Nessus user's password.
    - List current Nessus users.

## Requirements
- Tenable.sc (formerly SecurityCenter) and/or Nessus installed on the system.
- Root or sudo access on a Linux or MAC system is required to run the script.

## Usage
To use the script:
1. Clone this repository or download the script.
2. Ensure the script has executable permissions:
```bash
chmod +x Tenable-Utility.sh
```
3. Run the script with root privileges
```bash
sudo ./Tenable-Utility.sh
```
When executed, the script will display a menu that allows you to choose from various administrative options related to Tenable.sc and Nessus.

## Menus
### Tenable.sc User Management
After running the script, you'll be presented with a menu. Pick an option to perform the corresponding task:
```bash
------------------------------------------------
        What do you want to do?
1. Unlock admin account     | 4. Lock admin account
2. Unlock all accounts      | 5. Lock all accounts
3. Unlock one account       | 6. Lock one account

7. Reset user password      | 8. Manage Nessus accounts
9. Exit program
```
### Nessus User Management Menu
If you select option `8`, you'll enter the Nessus User Management menu where you can manage Nessus user accounts:
```bash
Nessus User Management
1. Add user    | 3. Change password
2. Remove user | 4. Exit
```

## Contributing
Contributions are welcome! If you would like to improve or extend the functionality of this script, feel free to submit a pull request or open an issue to discuss your ideas. Please ensure that any contributions follow best practices for shell scripting and maintain compatibility with both Tenable.sc and Nessus environments.
