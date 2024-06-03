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

# Install required utilities
sudo yum install -y yum-utils

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Add Centos Extras repo
cat << EOT >> /etc/yum.repos.d/centos-extras.repo
[centos-extras]
name=Centos extras - \$basearch
baseurl=http://mirror.centos.org/centos/7/extras/x86_64
enabled=1
gpgcheck=0
EOT

# Install other dependencies
sudo yum -y install slirp4netns fuse-overlayfs container-selinux

# Install Docker
sudo yum -y install docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Backup original file
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Search and replace the text
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Restart the sshd service to apply changes
sudo systemctl restart sshd

# Configuration and creation Jenkins Agent Containemkdir /docker/containers/jenkins
mkdir /docker-containers/jenkins
cd /docker-containers/jenkins
ln -s /docker-repo/jenkins conf
cd conf
cp jenkins-agent-fiumicino.yml jenkins-agent-cachoeirinha.yml
echo Jenkins Agent:docker-containers:jenkins:jenkins:jenkins-agent-cachoeirinha >> /docker-containers/.env

#Replace the lines on the compose file
sed -i '/\s*- JENKINS_SECRET=/ s/\=.*/=pastkeyhere/' /docker-containers/jenkins/conf/jenkins-agent-cachoeirinha.yml
sed -i '/\s*- JENKINS_AGENT_NAME=/s/\=.*/=agent_cachoeirinha/' /docker-containers/jenkins/conf/jenkins-agent-cachoeirinha.yml


