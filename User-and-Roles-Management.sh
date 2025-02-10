sudo groupadd developers

for user in User1 User2 User3 User4 User5; do
    sudo useradd -m -g developers "$user"
    sudo passwd "$user"
done

sudo mkdir -p /var/www/project
sudo chown root:developers /var/www/project
sudo chmod 750 /var/www/project

dpkg -l | grep openssh-server
If you see output, SSH is installed.

If you see no output, install it:
sudo apt update
sudo apt install openssh-server -y

echo "DenyUsers Daniel Pelumi" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart ssh