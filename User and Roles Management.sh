# User and Roles Management
# Your company recently hired five new developers who need access to the development server. Your task is to:
# Create user accounts for them and add them to the developers group.
# Ensure they have read and execute permissions for /var/www/project but cannot modify files.
# Restrict SSH access for two of them, who should only log in locally.


# Solutions

#!/bin/bash

# 1. Creating the user accounts and adding them to the 'developers' group 
# Creating the 'developers' group first
sudo groupadd developers

# Creating five user accounts and adding them to the 'developers' group
for user in User1 User2 User3 User4 User5; do
    echo "Creating user: $user"
    sudo useradd -m -g developers "$user"  # Create user with home directory (-m) and assign to group (-g)
    echo "Setting password for: $user"
    sudo passwd "$user"  # Prompt for password setup
done


# 2. Creating the /var/www/project to set read and execute permissions
# Create the project directory
sudo mkdir -p /var/www/project

# Set ownership: root owns it, but 'developers' group has access
sudo chown root:developers /var/www/project

# Set permissions:
#  - Owner (root) can read, write, and execute (7)
#  - Group (developers) can read and execute (5) but not write
#  - Others have no permissions (0)
sudo chmod 750 /var/www/project


# 3. Restricting SSH access for two users who should only log in locally
# Check if OpenSSH server is installed
if ! dpkg -l | grep -q openssh-server; then
    echo "OpenSSH server is not installed. Installing now..."
    sudo apt update && sudo apt install openssh-server
else
    echo "OpenSSH server is already installed."
fi

# Restrict SSH access for 2 specific users
echo "DenyUsers User1 User2" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH service to apply changes
sudo systemctl restart ssh