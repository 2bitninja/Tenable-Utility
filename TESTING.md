# Testing the Tenable-Utility Script
Thank you for testing the Tenable-Utility script! This page will guide you through setting up the environment and running tests to ensure that the script functions as expected.
## Prerequisites
Before testing, please ensure the following:
- You are running the script on a Linux machine.
- You have root (sudo) access to run the script.
- Tenable.sc and Nessus are installed for full feature testing.

## Setting Up for Testing
### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/Tenable-Utility.git
cd Tenable-Utility
```
### 2. Make the Script Executable
```bash
chmod +x tenable_utility.sh
```
### 3. Running the Script
Run the script using sudo to ensure it has the necessary permissions:
```bash
sudo ./tenable_utility.sh
```
If Tenable.sc or Nessus are not installed, the script will notify you of their status and certain functions will be unavailable for testing.

### 4. Test Cases
1. Test: Script Welcome Message
- The script should display a welcome message and show the installation status of Tenable.sc and Nessus.

Expected Output:
```bash
==============================================
          Welcome to the Tenable Utility
          Script for Managing Tenable.sc
            and Nessus User Accounts
==============================================

      This script helps you manage user
     accounts in Tenable.sc and Nessus.

Tenable.sc:   Not installed (or version number)
Nessus:       Not installed (or version number)

```
### 2. Test: Admin Account Unlock
```bash
------------------------------------------------
        What do you want to do?
1. Unlock admin account     | 4. Lock admin account
2. Unlock all accounts      | 5. Lock all accounts
3. Unlock one account       | 6. Lock one account

7. Reset user password      | 8. Manage Nessus accounts
9. Exit program
```
- Select the option to unlock the admin account:
    - Option 1: "Unlock admin account."
```bash
Admin account unlocked. (or appropriate error if Tenable.sc is not installed)
```
### 3. Test: Reset User Password
- Select the option to reset a user’s password:
    - Option 7: "Reset user password."

Expected Output:
```bash
Enter username to reset password: testuser
Password reset to 'password'. Please change it after login.
```
### 4. Test: Nessus User Management (if Nessus is installed)
- Select the option to manage Nessus users.
    - Option 8: "Manage Nessus accounts."

Expected Output:
```bash
These are the users on the Nessus scanner
Nessus User Management
1. Add user    | 3. Change password
2. Remove user | 4. Exit
```
### 5. Test: Error Handling (If Tenable.sc or Nessus are not installed)
- If Tenable.sc or Nessus are not installed, try running options related to them (e.g., locking/unlocking accounts, managing Nessus users).
- The script should display appropriate error messages like:
```bash
Tenable.sc is not installed, unable to unlock admin account.
```
### 5. Exit Script
To exit the script, select:
- Option 9: "Exit program."
## Reporting Issues
If you encounter any bugs, errors, or have suggestions, please open an issue in the repository and provide details of the problem:
- Error messages (if any).
- Operating system and version.
- Steps to reproduce the issue.
## Contributing
Feel free to contribute to the project by submitting pull requests with bug fixes, improvements, or new features.

