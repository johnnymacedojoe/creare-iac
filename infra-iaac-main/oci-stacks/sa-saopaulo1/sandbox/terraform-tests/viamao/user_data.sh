#!/bin/bash
sudo yum upgrade -y

# Create startdocker.sh script
cat << EOT >> /root/startdocker.sh 
#!/bin/bash
TRY=0
while [[ "$TRY" -lt "10" ]]
do
  DISCOS=$(df -h | grep "docker-containers\|var/lib/docker\|stage\|docker-uploads\|docker-repo" | wc -l)
  if [ "$DISCOS" -eq 5 ]; then
    systemctl start docker
    exit 0
  fi
  TRY=$((TRY+1))
  sleep 20
done
EOT

# Make the script executable
chmod +x /root/startdocker.sh

# Add a cron job to execute the script at reboot
echo "@reboot root /root/startdocker.sh" >> /etc/crontab

# Backup original file
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Search and replace the text
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Restart the sshd service to apply changes
sudo systemctl restart sshd




