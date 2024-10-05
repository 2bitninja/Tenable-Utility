# Tenable-Utility
Tenable-Utility is a script designed to streamline the management of user accounts in Tenable.sc and Nessus. This utility allows for locking and unlocking accounts, resetting passwords, and managing Nessus users efficiently.

Additionally, the script can check the installation status and version numbers of both Tenable.sc and Nessus, helping administrators easily verify that these applications are installed and up to date.


## Features
- Unlock or lock the admin or all user accounts in Tenable.sc.
- Unlock or lock a specific user by providing their user ID.
- Reset the password for a Tenable.sc user to a predefined value.
- Manage Nessus user accounts:
    - Add a new Nessus user.
    - Remove an existing Nessus user.
    - Change a Nessus user's password.
    - List current Nessus users.
- Display the installation status and version numbers of Tenable.sc and Nessus.
   

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
Once the script is executed, you will see a welcome message and a menu of options to manage Tenable.sc and Nessus user accounts. The script will also display the installation status and version numbers of Tenable.sc and Nessus to help verify if they are installed and working as expected.

### Example Installation Status Output:
```bash
Tenable.sc:   6.4.0
Nessus:       10.8.0
```

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
