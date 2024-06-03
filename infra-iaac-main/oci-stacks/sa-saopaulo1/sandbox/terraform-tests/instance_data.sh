
Ajustar o SSH permitindo autenticação por senha
vim /etc/ssh/sshd_config
PasswordAuthentication yes
service sshd restart

Desativar o SELINUX
/etc/selinux/config
colocar permissive

dnf -y install openldap-clients sssd sssd-ldap oddjob-mkhomedir openssl-perl 

vi /etc/sssd/sssd.conf 

" 
[sssd] 
services = nss, pam 
config_file_version = 2 
domains = LDAP 

[nss] 
homedir_substring = /home 

[domain/LDAP] 
id_provider = ldap 
ldap_uri = ldap://ldap.creare.intranet
ldap_search_base = dc=creare,dc=local 
ldap_default_bind_dn = cn=admin,dc=creare,dc=local 
ldap_default_authtok = password
ldap_search_filter = (objectClass=posixAccount) ;ldap_search_filter = (&(objectClass=posixAccount)(employeeType=ssh))   

cache_credentials = True 

ldap_tls_reqcert = allow 
ldap_id_use_start_tls = True 
ldap_tls_cacertdir = /etc/openldap/certs 

" 

Append on /etc/openldap/ldap.conf 

BASE    dc=creare,dc=local 
URI     ldap://ldap.creare.intranet
TLS_REQCERT never --> this is used to doesn check the certificate send from the server 

authselect select sssd with-mkhomedir –force 

systemctl enable sssd.service --now 
systemctl enable oddjobd.service --now 

Criar os seguintes diretorios:
mkdir /docker-containers
mkdir /docker-repo
mkdir /docker-uploads
mkdir /stage
mkdir /iot
mkdir /appdata
mkdir /var/lib/docker


Adicionar no /etc/fstab:
10.1.1.50:/DockerUploads    /docker-uploads nfs defaults,noatime,_netdev      0      2
10.1.1.50:/DockerRepository /docker-repo    nfs defaults,noatime,_netdev      0      2
10.1.1.50:/stage            /stage          nfs defaults,noatime,_netdev      0      2
10.1.1.50:/appdata          /appdata        nfs defaults 0 0
10.1.1.51:/iot              /iot            nfs defaults 0 0


montar os diretorios do fstab

caso tenha sido entregue um disco para o /var/lib/docker add ele no fstab e montar tb
caso tenha sido entregue um disco para o /docker-containers add ele no fstab e montar tb

adicionar as linhas abaixo no /etc/bashrc (tem que ver certo o "pais" do servidor):
. /docker-repo/generic_scripts/alias.sh
. /docker-repo/generic_scripts/colors.sh INGLATERRA

Ajustar timezone:
sudo timedatectl set-timezone America/Sao_Paulo

 #parei AQUI

Instalar ferramentas extras:
rpm -i https://download-ib01.fedoraproject.org/pub/epel/9/Everything/aarch64/Packages/n/nmon-16n-3.el9.aarch64.rpm
dnf install -y git iotop dialog

Install docker:
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


systemctl start docker

Criar o script startdocker.sh no /root com o seguinte conteudo
#!/bin/bash
TRY=0
while [[ "$TRY" -lt "10" ]]
do
  DISCOS=$(df -h | grep "var/lib/docker\|stage\|docker-uploads\|docker-repo\|iot\|appdata" | wc -l)
  if [ "$DISCOS" == 6 ]; then
    systemctl start docker
    exit 0
  fi
  TRY=$((TRY+1))
  sleep 20
done

Dar permissao pro script:
chmod +x /root/startdocker.sh

Adicionar no /etc/crontab:
@reboot root /root/startdocker.sh
#fazer ate aqui

Observação: o script anterior está comparando o $DISCOS com 6 que é o caso quando o server tem entregues os discos do docker-containers e var-lib-docker. Caso nao tenha, tem q comparar com 4

Instalar o docker-compose (observação, a URL é diferente se for x86 ou arm):
X86: curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o docker-compose
ARM: curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-aarch64 -o docker-compose

chmod +x docker-compose
mv docker-compose /usr/local/bin
ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

Criar o link simbolico do dockerctl
ln -sf /docker-repo/generic_scripts/dockerctl.sh /usr/bin/dockerctl

Instalar ctop (tb depende da arquitetura):
X86: curl -SL https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -o ctop
ARM: curl -SL https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-arm64 -o ctop
chmod +x ctop
mv ctop /usr/bin/