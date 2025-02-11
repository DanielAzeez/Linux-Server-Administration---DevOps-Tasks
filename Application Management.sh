# Your development team has requested the installation of Nginx for a new microservice. They also need:
# Your tasks are to install and setup
# The Nginx service to start automatically on boot.
# A check to ensure it is running properly after installation.
# The ability to restart it if it crashes.
 

# 1. Installing and setting up the Nginx service to start automatically on boot
# Update package lists before installation
sudo apt update  

# Install Nginx web server
sudo apt install nginx 

# Enable Nginx to start on boot
sudo systemctl enable nginx  

# 2. Check if Nginx is running properly after installation
sudo systemctl status nginx  

# 3. Restarting Nginx if it crashes
sudo systemctl restart nginx  
