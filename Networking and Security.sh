# Security is a top priority at HypotheticalCorp. Your company policy requires:
# Your tasks are to configure these security measures on your Linux server?
# Blocking all incoming traffic except SSH and HTTP.
# Checking which ports are currently open on the system.
# Setting up an SSH key-based authentication to eliminate password logins.

# Solutions

#!/bin/bash

# 1. Block All Incoming Traffic Except SSH (Port 22) & HTTP (Port 80)
# Ensure UFW is installed
sudo apt update && sudo apt install ufw  

# Allow SSH (Port 22) for remote access
sudo ufw allow 22/tcp  

# Allow HTTP (Port 80) for web traffic
sudo ufw allow 80/tcp  

# Deny all other incoming traffic by default
sudo ufw default deny incoming  

# Enable the firewall
sudo ufw enable  

# Verify Firewall status 
sudo ufw status verbose  


# 2. Checking which ports are currently open on the system
# List open ports with associated services
sudo ss -tulnp 


# 3. Setting up an SSH Key-based authentication to eliminate password logins
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Copy the SSH key to the local Server 
ssh-copy-id username@your-server-ip #(Run the 'hostname -I' command to find your local server ip)

# Editing the SSH configuration file to eliminate password login on the server
sudo nano /etc/ssh/ssh_config

# Find and modify these lines or add it if doesn't exist
PasswordAuthentication no

# Restart the SSH service
sudo systemctl restart ssh
