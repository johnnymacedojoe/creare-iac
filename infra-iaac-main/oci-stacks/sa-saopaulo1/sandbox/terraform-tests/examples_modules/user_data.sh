#!/bin/bash
sudo yum upgrade -y
echo "#@reboot root /root/startdocker.sh" >> /etc/crontab
echo <<EOT>> /root/startdocker.sh
"#!/bin/bash
TRY=0
while [[ "$TRY" -lt "10" ]]
do
  DISCOS=$(df -h | grep "docker-containers\|var/lib/docker\|stage\|docker-uploads\|docker-repo\|iot\|appdata" | wc -l)
  if [ "$DISCOS" == 7 ]; then
    systemctl start docker
    exit 0
  fi
  TRY=$((TRY+1))
  sleep 20
done"
EOT

sudo yum install -y yum-utils​
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo <<EOT>> /root/startdocker.sh
"[centos-extras]
name=Centos extras - $basearch
baseurl=http://mirror.centos.org/centos/7/extras/x86_64
enabled=1
gpgcheck=0"
EOT


sudo yum -y install slirp4netns fuse-overlayfs container-selinux
sudo yum -y install docker-ce docker-ce-cli containerd.io
systemctl start docker