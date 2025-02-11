# **Linux Server Administration - DevOps Tasks**
This repository documents essential Linux server administration tasks focusing on **user management, system monitoring, performance analysis, security configuration, and web server setup**. These tasks ensure efficient and secure operations for a development team.

## **Prerequisites**
Before starting, ensure you have:
- A **Linux-based server** (e.g., Ubuntu 20.04/22.04)
- **Superuser (sudo) privileges** to execute administrative tasks
- A **basic understanding of Linux commands** 

---

## **📌Task 1: User and Roles Management**
### **📝Scenario**
Your company has hired five new developers who need access to the development server.  
- You need to **create user accounts** for them and add them to a group called `developers`.  
- Ensure they have **read and execute permissions** for `/var/www/project`, but **cannot modify files**.  
- **Restrict SSH access** for two users (`User1` and `User2`), allowing only local logins.

---

### **🔧Step 1: Creating Users and Assigning Them to a Group**
1. **Create the "developers" group**  
   ```bash
   sudo groupadd developers
   ```
2. **Create five user accounts and assign them to the "developers" group**  
   Run the following script to automate the process:
   ```bash
   #!/bin/bash
   for user in User1 User2 User3 User4 User5; do
       echo "Creating user: $user"
       sudo useradd -m -g developers "$user"  # Create user and assign to group
       echo "Setting password for: $user"
       sudo passwd "$user"  # Prompt to set password
   done
   ```
   - `-m` creates a home directory for each user.
   - `-g developers` assigns them to the `developers` group.

---

### **🔧Step 2: Setting Directory Permissions**
1. **Create the project directory**
   ```bash
   sudo mkdir -p /var/www/project
   ```
2. **Change ownership so "developers" can access it**
   ```bash
   sudo chown root:developers /var/www/project
   ```
3. **Set permissions**
   ```bash
   sudo chmod 750 /var/www/project
   ```
   - `7` (Owner - root): **Read, Write, Execute**  
   - `5` (Group - developers): **Read & Execute** (no write access)  
   - `0` (Others): **No permissions**  

---

### **🔧Step 3: Restricting SSH Access for Two Users**
1. **Ensure OpenSSH Server is installed**  
   ```bash
   dpkg -l | grep openssh-server
   ```
   If not installed:
   ```bash
   sudo apt update && sudo apt install openssh-server
   ```
2. **Deny SSH login for `User1` and `User2`**
   ```bash
   echo "DenyUsers User1 User2" | sudo tee -a /etc/ssh/sshd_config
   ```
3. **Restart SSH service to apply changes**  
   ```bash
   sudo systemctl restart ssh
   ```
   This applies the new settings.

---

## **📌Task 2: System Monitoring & Performance Analysis**
### **📝Scenario**
Your team has reported **server slowness during peak hours**. Your goal is to:
- Identify the **top resource-consuming processes**.
- Check **disk usage**, ensuring logs are not consuming excessive space.
- Monitor **real-time system logs** for anomalies.

---

### **🔧Step 1: Identify Resource-Consuming Processes**
1. Run **top** command:
   ```bash
   top
   ```
   - Press **Shift + P** to sort by CPU usage.
   - Press **Shift + M** to sort by Memory usage.

2. If an unnecessary process is consuming resources, terminate it:
   ```bash
   sudo kill -9 <PID>
   ```
   (Replace `<PID>` with the actual process ID)

---

### **🔧Step 2: Check Disk Usage**
1. **Check overall disk space**  
   ```bash
   df -h
   ```
2. **Check logs directory size**  
   ```bash
   du -sh /var/log
   ```
3. **Find the largest log files**  
   ```bash
   du -ah /var/log | sort -rh | head -5
   ```
   (The -5 flag returns the first five largest log files. You can replace 5 with the number of log files you want to see.)

---

### **🔧Step 3: Monitor Real-Time Logs for Anomalies**
```bash
sudo journalctl -f
```
- This **streams live system logs**, helping to detect unusual activities, errors or anomalies.

---

## **📌 Task 3: Application Management (Installing and Managing Nginx)**
### **📝Scenario**
The development team needs an **Nginx web server** for a new microservice. You need to:
- Install and enable Nginx.
- Ensure it **starts on boot**.
- Verify if it is running.
- Restart it when necessary.

---

### **🔧Step 1: Install Nginx**
```bash
sudo apt update
sudo apt install nginx 
```

---

### **🔧Step 2: Enable & Check Nginx Status**
1. **Enable Nginx to start on boot**
   ```bash
   sudo systemctl enable nginx
   ```
2. **Check if Nginx is running**
   ```bash
   sudo systemctl status nginx
   ```

---

### **🔧Step 3: Restart Nginx if it crashes**
```bash
sudo systemctl restart nginx
```

---

## **📌Task 4: Networking and Security**
### **📝Scenario**
Security is a **top priority** at HypotheticalCorp. Your task is to:
- **Block all incoming traffic** except **SSH (22)** and **HTTP (80)**.
- Check **which ports are currently open**.
- Set up **SSH key-based authentication**.

---

### **🔧Step 1: Block Incoming Traffic (Except SSH & HTTP)**
1. **Ensure UFW is installed**  
   ```bash
   sudo apt update && sudo apt install ufw
   ```
2. **Allow SSH (Port 22)**  
   ```bash
   sudo ufw allow 22/tcp
   ```
3. **Allow HTTP (Port 80)**  
   ```bash
   sudo ufw allow 80/tcp
   ```
4. **Deny all other incoming traffic**  
   ```bash
   sudo ufw default deny incoming
   ```
5. **Enable the firewall**  
   ```bash
   sudo ufw enable
   ```
6. **Verify firewall status**  
   ```bash
   sudo ufw status verbose
   ```

---

### **🔧Step 2: Check Open Ports**
```bash
sudo ss -tulnp
```
- `-t` (TCP), `-u` (UDP), `-l` (Listening ports), `-n` (Numeric format), `-p` (Processes using ports)

---

### **🔧Step 3: Set Up SSH Key-Based Authentication**
1. **Generate an SSH Key Pair**  
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
2. **Copy the SSH Key to the Server**  
   ```bash
   ssh-copy-id username@your-server-ip
   ```
   (You can generate your local server ip by running the 'Hostname -I' command.)
3. **Disable Password Login for SSH**
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
   - Modify the following lines:
     ```
     PasswordAuthentication no
     PermitRootLogin no
     ```
4. **Restart SSH service**  
   ```bash
   sudo systemctl restart ssh
   ```

---

## **Conclusion**
This guide covers **step-by-step** instructions to **manage users, monitor system performance, set up a web server, and enhance security** on a Linux system, in an easy-to-follow manner.

---
